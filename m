Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DE92F970E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbhARBCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:02:14 -0500
Received: from mail.codeweavers.com ([50.203.203.244]:56934 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbhARA7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 19:59:19 -0500
X-Greylist: delayed 947 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2021 19:59:17 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Type:MIME-Version:Date:Message-ID:
        Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qGmc+gmQh8S+nIs5EFbX/ATJJE6zz/qHbJEFfHRd+IY=; b=jTzHAkKVXPVQX2uUVNMHEjKnQH
        6bM8+IQg5ji+OrGxwDA9hcoORuaXiHu2Pf6ii9qsB1qFmPQ5CqsHdUqaSGIaoNjWitltQR6bMxMsn
        RdNe86TurfWqLXhUQJGM9XsdNTlFAj3++lm1S6iaJLYr73YPpd/RTRwNctQhZ1ZjjBlU=;
Received: from [10.69.139.6]
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <zfigura@codeweavers.com>)
        id 1l1Ics-0005Sv-3V; Sun, 17 Jan 2021 18:42:36 -0600
From:   Zebediah Figura <zfigura@codeweavers.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Wine Devel <wine-devel@winehq.org>
Subject: Kernel interface for Wine synchronization primitives
Message-ID: <f4cc1a38-1441-62f8-47e4-0c67f5ad1d43@codeweavers.com>
Date:   Sun, 17 Jan 2021 18:42:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="x0Gjfq9AtudA1zibtLyzIrYOhPa8NsZxs"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x0Gjfq9AtudA1zibtLyzIrYOhPa8NsZxs
Content-Type: multipart/mixed; boundary="w85pUZsb0tdkDckUu8xuVEWM7fEMju7Iv";
 protected-headers="v1"
From: Zebediah Figura <zfigura@codeweavers.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Darren Hart <dvhart@infradead.org>, Wine Devel <wine-devel@winehq.org>
Message-ID: <f4cc1a38-1441-62f8-47e4-0c67f5ad1d43@codeweavers.com>
Subject: Kernel interface for Wine synchronization primitives

--w85pUZsb0tdkDckUu8xuVEWM7fEMju7Iv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello all,

[I've added to CC those people listed as maintainers in the areas of
locking and futexes, in the hopes that they will be able to offer their
expertise on a problem related to synchronization primitives.]

As a basic summary to what follows, we at the Wine project are looking
to introduce a kernel API that will allow us to implement Windows NT
synchronization object API with at most one syscall per operation, and
without managing object state in user-managed shared memory, for the
sake of performance. I'm hoping to get opinions with this mail as to
what such an API should look like, or whether it would be accepted.

Apologies if what follows is overly verbose; I try to err on that side
in order to provide all of the necessary context. Section 4 of this mail
contains a relatively concrete UAPI proposal.



    0. TABLE OF CONTENTS

        1. BACKGROUND
        2. REQUIREMENTS
        3. WHY IT CAN'T BE DONE WITH EXISTING TOOLS
        4. PROPOSAL
        APPENDIX: PERFORMANCE IMPROVEMENTS DUE TO "ESYNC"



    1. BACKGROUND

I am a contributor to the Wine project (which, in case anyone is
unfamiliar, is a translation layer allowing Windows programs to run on
POSIX systems). Windows NT has a set of synchronization primitives,
essentially all of which are stateful and can be shared between
processes. I've written a detailed description of these primitives
below. Because these objects can be shared between processes, Wine
implements them using a dedicated 'wineserver' process, which receives
requests from "client" processes somewhat analogous to system calls. For
example, server requests exist corresponding to "release [up] a
semaphore" and "wait for an object to be signaled". Each server request
is a remote procedure call to the wineserver process, wherein data is
sent over a socket from the client to the server, the server performs
some operation, and then sends a reply back to the client.

(This "wineserver" process also manages many other features managed by
the Windows kernel, such as window management, asynchronous I/O, process
and thread state, named pipes, etc.)

In recent years applications, especially high-performance games, have
made heavy use of multiple threads, and consequently heavy use of these
synchronization primitives. The RPC to the wineserver has become not
just a bottleneck, but a heavy bottleneck. It's particularly a problem
because the server is single-threaded and can only service one request
at a time. A few years ago I wrote a set of out-of-tree patches for
Wine, colloquially called "esync", that reimplements the
performance-critical parts of many of these operations on top of the
eventfd interface, with NT kernel objects essentially mapping directly
to eventfd objects, plus some extra state which lives in shared memory.
To a large degree this results in theoretically equal performance with
Windows; most operations which are understood to comprise one system
call on Windows now also comprise one system call (to the Linux kernel)
on Wine. The actual performance improvement is, depending on the
application, quite substantial; I've attached some data as a postscript
to this mail.

However, "esync" has its problems. There are some areas where eventfd
just doesn't provide the necessary interfaces for NT kernel APIs, and we
have to badly emulate them. As a result there are some applications that
simply don't work with it. It also relies on shared memory being mapped
read/write into every application; as a result object state can easily
be corrupted by a misbehaving process. These problems have led to its
remaining out of tree. There are also some operations that need more
than one system call and hence could theoretically be improved
performance-wise.

I later developed a second out-of-tree patch set, the awfully named
"fsync", which uses futexes instead of eventfds. It was developed by
request, on the grounds that futexes can be faster than eventfds (since
an uncontended object needs no syscalls). In practice, there is
sometimes a positive performance difference, sometimes a negative one,
and often no measurable difference at all; it also sometimes makes
performance much less consistent. It shares all of the same problems as
"esync", including (to a degree) some inefficiencies when executing
contended waits.

Having not yet found an interface that provides what we need, my goal is
to introduce to the Linux kernel an interface=E2=80=94either based on an
existing one, or designed from the ground up=E2=80=94that exposes the mis=
sing
pieces, allows for ideally at least equal performance with Windows, and
which can be used in mainstream Wine.

I'm not immediately sure what form this API should take, however.
Extending existing APIs such as eventfd does not seem particularly
attractive [especially given that the semantics of APIs like
NtWaitForMultipleObjects() and NtPulseEvent() are very fundamentally
different from the way that POSIX file descriptors work]. There are many
very badly designed parts=E2=80=94including APIs that Microsoft has publi=
cly
deprecated=E2=80=94that we nevertheless have to perfectly emulate, and so=

designing a new explicitly general-purpose API that covers this does
also not seem particularly attractive. I don't think we want to
encourage actual use (outside of API translation) of the ugly parts, and
most of the non-ugly parts are pretty much already covered by existing
tools like eventfd. On the other hand, API translation is itself an
important use case.



    2. REQUIREMENTS

In order to give an idea of what we actually need, from the Wine side,
I've described below the behaviour of the Windows NT primitives we're
trying to emulate. This isn't necessarily the API that I'm proposing
needs to exist in the kernel; I'm rather trying to describe the problem
so that a solution of some sort can be found, including maybe something
I've missed that doesn't require kernel changes.

Windows kernel objects are exposed to user space via "handles", which
are 32- or 64-bit values (depending on architecture) roughly analogous
to file descriptors. Like file descriptors, multiple handles can refer
to the same object, and have different access flags. In the case of
synchronization primitives, there are three different access flags,
roughly corresponding to "wait", "modify", and "read" operations, but
the actual semantics are rather strange.

There are four primary types of synchronization primitive we care about:

* Semaphore - a classic semaphore object. It holds one 32-bit value of
dynamic state, which can be decreased by one [i.e. acquire] or increased
by an arbitrary amount [i.e. release]; the object is "signaled" when
this value is nonzero. It also holds a second, static 32-bit value
denoting the maximum count; an attempt to post past this maximum results
in an error.

* Mutex (or "mutant") - a classic recursive mutex. This holds one 32-bit
value denoting the current recursion count, as well as some reference to
the thread which owns it. A thread which exits (normally or violently)
while holding a mutex "abandons" it, and the user-space API makes a
distinction as to whether a mutex is signaled normally or abandoned
(much like pthread mutexes and EOWNERDEAD.)

* Manual-reset event - holds a single boolean value denoting whether the
object is signaled or nonsignaled. "Wait" operations do not change the
state of this object.

* Auto-reset event - as above; however, "wait" operations do reset the
state to nonsignaled (more details below).

[As a bit of an aside, there are more types of synchronizable objects
than this, including e.g. processes and threads, which much like pidfd
are considered signaled when the process exits. However, these objects
are not thus far a performance concern, and can thus be implemented on
top of one of the objects above.]

There are a rather large number of system calls that we need to implement=
:

* NtWaitForSingleObject - This is a rather complex operation. It takes
an object of any type and a timeout (which may be "infinite"), sleeps
until the object is signaled or the timeout expires, and atomically
"consumes" the object if appropriate. In detail:

  - A semaphore is considered signaled if its count is nonzero, and
consumed by decreasing the count by one. This is the only way to acquire
a semaphore; there is no distinct semaphore-specific "down" operation.

  - A mutex is considered signaled if it is already owned by the current
thread or if it is unowned. It is consumed by granting ownership to the
current thread (if it is not already owned) and increasing its recursion
count by one. This is the only way to acquire a mutex. The return value
to this function also includes a flag denoting whether the mutex was
abandoned.

  - An event is considered signaled if it is in the signaled state. A
manual-reset event is not affected by this function; an auto-reset event
is atomically reset to the nonsignaled state. [An auto-reset event is
somewhat similar to a non-recursive mutex, though it is not usually used
that way].

  The caller must have "wait" access to the object, or this function
fails. Note that even though the call may modify state, "modify" access
is not required.

* NtWaitForMultipleObjects - Essentially a superset of the above [in
particular, NtWaitForSingleObject can be trivially implemented on top of
NtWaitForMultipleObjects], but for the sake of clarity I've separated it
here. This function receives up to a fixed limit of 64 handles. It has
two modes of operation:

  - wait for any of the objects to become signaled, atomically consuming
[at most] one object;

  - wait for *all* of the objects to become signaled, atomically
consuming all of them at once. Times out if all of the objects are never
simultaneously signaled. This operation is rarely used in practice.

  Furthermore, the function can optionally be made "alertable", in which
case certain kernel APIs will cause it to return with a special code.
Note that in the case of wait-all, the function can therefore return in
one of three ways: timeout, alert, or when all objects are signaled and
consumed.

  As above, the caller must have "wait" access to all objects, but no
other access is required.

* NtReleaseSemaphore - atomically increments the semaphore count by a
given 32-bit value, and returns the previous value. If threads are
waiting on the semaphore, they will be signaled, and the semaphore's
count decremented as appropriate. The caller must have "modify" access.

* NtQuerySemaphore - read the current and maximum semaphore count
without modifying the semaphore. The caller must have "read" access.

* NtReleaseMutant - atomically decrements the mutex recursion count by
one, and returns the previous count. If the count reaches zero,
relinquishes ownership of the mutex, and causes it to become signaled.
No access is required.

* NtQueryMutant - returns the current mutex recursion count, whether the
caller owns it, and whether it is "abandoned". The caller must have
"read" access.

* NtSetEvent - atomically sets an auto-reset or manual-reset event to
the signaled state, and returns its previous state. The caller must have
"modify" access.

* NtResetEvent - atomically sets an auto-reset or manual-reset event to
the nonsignaled state, and returns its previous state. The caller must
have "modify" access.

* NtPulseEvent - if the event is already signaled, set its state to
nonsignaled and return. Otherwise, if the event is an auto-reset event,
wakes up one thread (if any) waiting on the event; if the event is a
manual-reset event, wakes up all threads (if any) waiting on the event.
In both cases the event state is *not* changed to signaled. Note that a
thread inside of "wait-all" is only woken if all other objects are also
signaled. The caller must have "modify" access.[1]

* NtQueryEvent - returns whether the event is currently signaled, and
whether it is manual-reset or auto-reset. The caller must have "read"
access.

* NtSignalAndWaitForSingleObject - Set an object of any type to a
signaled state; depending on the object type, this is equivalent to
NtSetEvent, NtReleaseSemaphore (with a count of 1), or NtReleaseMutant.
Then, wait on another object, as with NtWaitForSingleObject. The objects
may be the same or different. If either handle is invalid (or has
insufficient access) the call fails and neither object is affected. The
two operations are not atomic, *but* if the call fails neither object
can be affected=E2=80=94i.e. we must protect against a race where one obj=
ect is
closed mid-call.

* NtDuplicateObject - This is not a synchronization-specific API, but
deserves some comment nonetheless. It's a much more generic version of
dup(), in which the caller in process A can specify to duplicate a
handle from process B into process C, and all three processes can be
different. The new handle can be given different access rights than the
original. There is also an optional flag allowing to close the source
handle at the same time. This is insane, of course=E2=80=94to allow a pro=
cess to
close another process's handles without its knowledge=E2=80=94but we need=
 to
implement it. This API alone is the cause of most of the difficulty
we've had optimizing synchronization primitives in user space. Without
it, it'd be easy to guess which objects need to be available
cross-process, and use some futex- or eventfd-based scheduling mechanism
within one process while using the slow server path for any
cross-process objects.

* A set of APIs that create or open objects, and one API (NtClose)
destroying them. These calls specify the ACL associated with the object,
and the rights requested when opening it. We're not concerned with the
speed of these APIs, however (and actually optimizing that would be a
lot more difficult anyway, as it interacts with a lot of other details
currently managed by the wine server).

If all handles to an object are closed while a thread is sleeping on it,
the thread is not interrupted, but rather behaves as if the object
remains unsignaled, i.e. the wait will either time out, be signaled by a
different object, or continue forever until interrupted in some other way=
=2E

Finally, a word deserves to be said regarding "abandoned" mutices. A
thread which terminates (gracefully or violently) while holding one or
more mutices releases those mutices, but sets an internal flag marking
them as "abandoned". This flag can be retrieved by NtQueryMutant, and is
also returned by NtWaitForSingleObject and NtWaitForMultipleObjects.

Broadly speaking, what we actually need to be fast is mostly limited to
the following operations:

* NtWaitForSingleObject
* NtWaitForMultipleObjects
* NtSetEvent
* NtResetEvent
* NtReleaseSemaphore
* NtReleaseMutant

i.e. the "signal" and "wait" operations for all three object types.
Other operations (create, open, close, query state, NtDuplicateObject,
and NtPulseEvent) are rare in critical paths, or rare in programs where
synchronization primitives are a bottleneck. Furthermore, the "wait-all"
case of NtWaitForMultipleObjects is also relatively rare as a bottleneck
[though I'm not confident to say that it never is a bottleneck].



    3. WHY IT CAN'T BE DONE WITH EXISTING TOOLS

An out-of-tree patch set has been already mentioned ("esync"), which
reimplements Win32 synchronization objects on top of eventfds, plus a
few bytes of shared memory per object for that dynamic state which
eventfd can't store. Semaphores use EFD_SEMAPHORE. Waiting is
implemented using a loop of poll(), all file descriptors having been
marked nonblocking, and a second call to read() to actually acquire the
object. There are a few general problems with this:

* NtPulseEvent can't work right. We badly emulate it by setting and then
immediately resetting the event, but due to the above gap between poll()
and read(), most threads end up missing the wakeup anyway.

* Wait-for-all-objects is kind of broken. We implement it by grabbing
each object in sequence and then undoing that operation if we fail to
grab any object.

* Storing object state in shared memory means that it can be corrupted.
It's not usually a problem in practice, of course, but it's not safe
enough for upstream.

The "fsync" patch set stores all of its state in shared memory, and uses
simple futex operations. It ends up working quite similarly, and shares
the exact same problems.

According to my reasoning, in order to really have PulseEvent work
right, we need explicit scheduler support. That does bring up the option
of having a "scheduler", i.e. managing wait-queues, in user space.
Unfortunately this still doesn't help with the shared memory problem=E2=80=
=94in
fact, now it's worse, because processes can die while holding locks that
the scheduler needs. This means that wineserver itself=E2=80=94the "kerne=
l" of
Wine applications=E2=80=94can be broken by a misbehaving process, which i=
s
absolutely unacceptable for Wine.

I've also thought about trying to implement a scheme whereby objects
live in-process until they're accessed by another process, at which
point they can be "migrated" down to the server. Since most usage (esp.
most performance-critical usage) is within a single process, this might
be feasible. However, it turns out to be hard if not impossible to avoid
races while migrating. I've also been warned that synchronization
between multiple processes is becoming more common (along the lines of
e.g. separate processes executing GPU work, IIUC).

I'd really love to be told that there's some user-space solution I'm
missing, but after considering the problem for multiple years I've yet
to find one.



    4. PROPOSAL

The following describes my best attempt at proposing a concrete
interface, and if I don't get any concrete feedback to this mail other
than "show me an implementation first", it's what I'll try to write up.

Introduce a module, let's call it "ntsync". [I'd propose "winesync", but
in theory I guess this could be useful to some other translation layer,
not that I know of any.] This will create a char device /dev/ntsync
which supports a set of ioctls. [My reasoning here is that we should
modularize this feature, since it's meant for a specific and not
ubiquitous program, and I'm presuming that this is the best way to
expose something from a module.] Each ioctl matches up relatively
closely to an NT syscall. Each ioctl on an object is atomic and totally
ordered with respect to other ioctls on the same object. The list of
ioctls is as follows:

- NTSYNC_IOCTL_CREATE_MANUAL_EVENT - Takes a single int denoting initial
state =E2=80=94 nonzero signaled, zero nonsignaled. Internally creates a
manual-reset event object, and returns a unique 32-bit integer
representing this object. (This need not match the Win32 handle; we can
map that trivially in user space.)

- NTSYNC_IOCTL_CREATE_AUTO_EVENT - As above (but creates an auto-reset
event).

- NTSYNC_IOCTL_CREATE_SEMAPHORE - Takes a struct of two ints denoting
initial count and maximum count; returns -EINVAL if initial > max.
Internally allocates a semaphore object and returns a unique 32-bit
integer representing it.

- NTSYNC_IOCTL_CREATE_MUTEX - Takes a single int denoting initial state
=E2=80=94 nonzero owned by the current thread (with recursion count 1), z=
ero
unowned. Internally creates a mutex, and returns a unique 32-bit integer
representing it.

- NTSYNC_IOCTL_CLOSE - Takes an object identifier returned by one of the
CREATE ioctls. Invalidates that object so that further ioctls on it
return -EBADF [not a great error code, but I'm not sure what's better.
It'd be nice to have a distinct error code, though.] Does not actually
destroy the object until all outstanding syscalls on the object have
executed it. [I.e. the objects are refcounted internally.] Does not
interrupt existing syscalls using the object.

- NTSYNC_IOCTL_WAIT_ANY - Takes an array of up to 65 identifiers [or
some number greater than 65, as 65 is a bit ugly], a count, and an
optional struct timespec pointer. Return -EINVAL if count < 1 or count >
65. Sleeps until at least one of the objects identified is in the
signaled state (if it is not already) or the timeout expires. If the
timeout expires, return -EAGAIN. Otherwise, consume exactly one object.
Returns the index into the array passed in. Separately, also returns a
flag denoting whether the signaling object was an abandoned mutex. A
semaphore is considered signaled if its count is nonzero; a mutex is
considered signaled if it is unowned or owned by the current thread.
Consumption means as follows:
  * a manual-reset event is unaffected;
  * an auto-reset event is reset to the nonsignaled state;
  * a semaphore has its count decreased by 1;
  * a mutex is marked as owned by the current thread [if it is not
already] and its recursion count is increased by 1.

- NTSYNC_IOCTL_WAIT_ALL - Much like the above. However, instead of
waiting for *any* of the objects to become signaled, wait for them all
to become simultaneously signaled [or for the timeout to expire], and
atomically consume them all at once if so. Hence, on success, it simply
returns 0 instead of an index.

- NTSYNC_IOCTL_SET_EVENT - Takes an object identifier returned by one of
the CREATE ioctls. If the event is a manual-reset event, set its state
to signaled, and wake up all eligible threads. If the event is an
auto-reset event, and there is at least one eligible thread waiting on
it, wake up that thread and leave the event unsignaled; if there are no
eligible threads waiting on it, set the event to signaled. Returns
-ENOSYS if not called on an event.

  (An "eligible" thread is defined as one whose wait condition is
satisfied=E2=80=94i.e. a thread executing an ANY wait is eligible if any =
of its
items are signaled; a thread executing an ALL wait is eligible if all of
its items are signaled.)

- NTSYNC_IOCTL_RESET_EVENT - Takes an object identifier returned by one
of the CREATE ioctls. Set the state of an auto- or manual-reset event to
nonsignaled. Returns -ENOSYS if not called on an event.

- NTSYNC_IOCTL_PULSE_EVENT - Takes an object identifier returned by one
of the CREATE ioctls. If the event is already signaled, this ioctl is
equivalent to NTSYNC_IOCTL_RESET_EVENT. Otherwise, if the event is an
auto-reset event and there is an eligible thread waiting on it, wake it
up. If the event is a manual-reset event, wake up all eligible threads
waiting on it. Do not change the state of the event to signaled. Returns
-ENOSYS if not called on an event.

- NTSYNC_IOCTL_READ_EVENT - Takes an object identifier returned by one
of the CREATE ioctls. Returns the event's state (signaled or
nonsignaled). Returns -ENOSYS if not called on an event.

- NTSYNC_IOCTL_RELEASE_SEMAPHORE - Takes an object identifier returned
by one of the CREATE ioctls, and a 32-bit integer "count". Return
-EOVERFLOW if "count" is greater than the internal maximum. Otherwise,
increase the internal count by "count", then, wake up the first at most
{internal count} eligible threads waiting on this semaphore, decreasing
{internal count} by 1 for each thread. This whole operation is of course
atomic. Returns -ENOSYS if not called on a semaphore.

- NTSYNC_IOCTL_READ_SEMAPHORE - Takes an object identifier returned by
one of the CREATE ioctls. Returns the semaphore's count. Returns -ENOSYS
if not called on a semaphore.

- NTSYNC_IOCTL_RELEASE_MUTEX - Takes an object identifier returned by
one of the CREATE ioctls. Return -EPERM if the calling thread does not
own the mutex. Otherwise, decrease the mutex's recursion count by 1. If
it reaches zero, and there is an eligible thread waiting on this
semaphore, wake it up and mark it as owner, setting the recursion count
back to 1. If there is no eligible thread, leave the mutex in an
"unowned" state. Returns -ENOSYS if not called on a mutex.

- NTSYNC_IOCTL_READ_MUTEX - Takes an object identifier returned by one
of the CREATE ioctls. Returns an int describing whether the mutex is
owned by the caller (1 if owned by the caller, 0 otherwise) and
similarly an int describing whether the mutex is abandoned. Returns
-ENOSYS if not called on a mutex.

- NTSYNC_IOCTL_ABANDON_MUTEX - Takes an object identifier and marks the
given mutex as abandoned and unowned. Returns -ENOSYS if not called on a
mutex.

- NTSYNC_IOCTL_SIGNAL_AND_WAIT - Takes two object identifiers and an
optional struct timespec pointer. Depending on the type of the first
object identifier, equivalent to NTSYNC_IOCTL_SET_EVENT,
NTSYNC_IOCTL_RELEASE_MUTEX, or NTSYNC_IOCTL_RELEASE_SEMAPHORE (with a
count of 1), followed by NTSYNC_IOCTL_WAIT_ANY on the second object. If
either object is invalid (has been closed), returns -EBADF and does not
affect the state of either object. (We can almost implement this in user
space without help from the kernel, except that we need to protect
against races where one object is closed mid-call.)

Note that we don't use fds for object handles, even though they're
analogous concepts. There are a couple reasons for this:

* Windows doesn't have a concept of NOFILE. Buggy programs exist which
leak hundreds of thousands of synch primitives. Google Earth VR is an
example. esync ships with a notice telling the user to raise the hard
limit for NOFILE; later systemd itself raised the default limit (not
solely because of esync, but it was the trigger).

* These objects are remarkably idiosyncratic in their behaviour. read()
and write() make less sense on them than they do on eventfd. poll()
barely makes sense, and in any case it's not useful for Wine=E2=80=94we n=
eed
combined atomic poll-and-acquire semantics.

All of the above object identifiers are per-fd.

Access control flags and handle duplication would be handled in user
space. We would have a one-to-one correspondence between objects and
UAPI identifiers; the kernel would therefore have a one-to-one
correspondence between UAPI identifiers and actual objects.

Alertable waits would also be handled in user space, via signals. Thus
we would need it to be guaranteed that a WAIT call return -EINTR on a
signal, so that we can check whether the thread is alerted.

For the sake of comparison, if an existing API like eventfd were instead
extended, here is a list of the things we would need.

* A blocking operation, like poll() that optionally consumes things, or
like read() on a vectored set of file descriptors. This doesn't
necessarily mean we have to replicate the manual/auto distinction in the
kernel; we can handle that in user space. This by itself doesn't
actually seem all that unreasonable, but...

* A blocking operation like the above, but corresponding to "wait-all";
i.e. which atomically reads from all descriptors. Just from skimming the
code surrounding things like read() and poll(), this seems very ugly to
implement.

* A way to atomically write() to an eventfd and retrieve its current
count [for semaphore and event operations].

* A way to signal an eventfd, such that waiters are woken, but without
changing its current count [i.e. an operation corresponding to
NtPulseEvent].

* A way to read the current count of an eventfd without changing it [for
NtQuerySemaphore and NtQueryMutant; for NtQueryEvent we can use poll.]

That concludes my description and proposal; I'd love to hear your thought=
s.

=E1=BC=94=CF=81=CF=81=CF=89=CF=83=CE=B8=CE=B5,
Zebediah Figura
(she/her)



[1] NtPulseEvent has been publicly deprecated by Microsoft for some
time, and is rarely used in modern programs. It's inherently racy (it
relies you to know whether a thread is actually waiting for your event,
which is in theory impossible, if in practice less so), and not only
that, but Microsoft warns that kernel threads sleeping on an event can
be arbitrarily un-scheduled in order to run an asynchronous kernel
procedure (I don't know why the kernel unqueues the thread in this case,
but I'm also not yet a kernel developer). In practice it was usually
used to implement a loose equivalent of alarm(2), before a better API
was invented for this, and so the rare race or missed wakeup was not a
problem.



    APPENDIX: PERFORMANCE IMPROVEMENTS DUE TO "ESYNC"

These are to some extent cherry-picked. The point isn't so much to show
that "esync" helps everything=E2=80=94it doesn't by any means=E2=80=94but=
 to show that
it does result in significant improvement for a non-negligible number of
applications.

Most of the following benchmarks measure FPS. A secondary benefit
though, that I have observed in practice (but unfortunately have no
numbers for, and at the moment don't particularly have the hardware to
reproduce) is that CPU utilization is greatly decreased, especially in
the wineserver process.

*
<https://github.com/ValveSoftware/Proton/issues/2966#issuecomment-5201877=
37>
- Thief (2014). Average FPS increase due to "esync" is 93 -> 123 FPS.

*
<https://github.com/ValveSoftware/Proton/issues/2966#issuecomment-5217926=
09>
- Grand Theft Auto V (2015). 100 -> 131 FPS.

* <https://www.youtube.com/watch?v=3DGRTPb-ar0sI> - Recorded benchmark of=

Grand Theft Auto V (2015) with a side-by-side comparison. There is not
always a visible difference between "esync" and server-side
synchronization; it depends largely on whether the game is CPU- or
GPU-limited at any given time. Unfortunately there are no average numbers=
=2E

The following benchmarks were all uploaded by the same user, apparently
with the same hardware (details are listed on each page) and also
include "fsync". They also include graphs taken over a larger time
period, giving more information than simply average FPS.

* <https://flightlessmango.com/games/1700/logs/778> - Assassin's Creed
Odyssey (2018). 50 -> 54 FPS.

* <https://flightlessmango.com/games/15605/logs/785> - Ori and the Will
of the Wisps (2020). 99 -> 115 FPS.

* <https://flightlessmango.com/games/2596/logs/786> - Bioshock (2007).
526 -> 622 FPS.

* <https://flightlessmango.com/games/2597/logs/789> - Bioshock 2 (2010).
313 -> 338 FPS.

* <https://flightlessmango.com/games/23256/logs/788> - The Witcher 3:
Wild Hunt (2016). 82 -> 90 FPS.


--w85pUZsb0tdkDckUu8xuVEWM7fEMju7Iv--

--x0Gjfq9AtudA1zibtLyzIrYOhPa8NsZxs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEENTo75Twe9rbPART3DZ01igeheEAFAmAE2XgFAwAAAAAACgkQDZ01igeheEBD
Jwf/ZEM7TC0rstaBv+tGjMFO013hgA3GpBD+kjvcHeouMG0ZfRC8fvuMNdcIF1+K42cjX4VGYZao
mjgqyb5jM0NBVSwpW8+G3d8TdqM4KlEHxeDl474CsUihueX1AkBrUbUGHihECIZURP5DZt3EprmZ
n5GtjjgNgRhyLSNLE106+cXL/OPDybSGg9Eb084vzK6cwksQaT3QGotpxGz9gWhnUQOVEqVAGTCL
MroaWYoJruoCtvKLueZxYMK7nmSNIcoNu+Mnn7ffqenW66gIJgJTT+UCSYwo1pBzpA40jSXTW6C+
L8LsFH8RUmnwKGfxSXQNQdeBh4HVG8G08U15kL0pPA==
=gOtd
-----END PGP SIGNATURE-----

--x0Gjfq9AtudA1zibtLyzIrYOhPa8NsZxs--
