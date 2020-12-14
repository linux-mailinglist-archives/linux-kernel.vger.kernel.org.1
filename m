Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613992DA17F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503265AbgLNU0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503166AbgLNU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:26:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67816C06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:25:28 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:22:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YtxiB/6sTmBMDmCRa/7BceUd2TGKPhgCyO1oQrFeLWI=;
        b=QRD/VqKMxLjHK61BEM6om7GXKJjuD7GIH/f0DTjW6jTXQix4YNVo1lO74iJq0g8es9wXfN
        Xhg9wXOQkNNnS5ruKDSnYfvHvolx7GKhcZ8jiiJ3LvN0Bk3+9W1HIcyUWkdVBqVA9bb8HU
        GMKCFyGt3gSN9gwpJsWiTRkganCC5GZkb3RrsbGthnr0UEvZ7KcD8c7mtCdj635LvYnhU+
        RHsg1GGQeuW58mKMbrFbEy46EVDfsZ8NncD2+XuPquqQohXJcESb158vgLbXUuRG1dnqMS
        TFRXoULYpUqVuCmW7DkKCDLZGsq2BxOXq5JJn1KyAaj4IGky2eYcPPw6cNyPXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=YtxiB/6sTmBMDmCRa/7BceUd2TGKPhgCyO1oQrFeLWI=;
        b=adJxIwSORu8pGqC8bsDPL2ZMgNjCuwo5dTvzIbWJMZl+NpwKcmkVrit1dtO5VTbuHol+NU
        FWtw2LTi6ThKqoAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/core for v5.11-rc1
References: <160797732939.10793.9152151866806316627.tglx@nanos>
Message-ID: <160797733425.10793.1616595353462792263.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2020-12-14

up to:  cb262935a166: seqlock: kernel-doc: Specify when preemption is automatically altered


A moderate set of locking updates:

  - A few extensions to the rwsem API and support for opportunistic
    spinning and lock stealing

  - lockdep selftest improvements

  - Documentation updates

  - Cleanups and small fixes all over the place

Thanks,

	tglx

------------------>
Ahmed S. Darwish (3):
      Documentation: seqlock: s/LOCKTYPE/LOCKNAME/g
      seqlock: Prefix internal seqcount_t-only macros with a "do_"
      seqlock: kernel-doc: Specify when preemption is automatically altered

Arnd Bergmann (1):
      seqlock: avoid -Wshadow warnings

Boqun Feng (1):
      lockdep/selftest: Add spin_nest_lock test

Eric W. Biederman (2):
      rwsem: Implement down_read_killable_nested
      rwsem: Implement down_read_interruptible

Lukas Bulwahn (1):
      futex: Remove unused empty compat_exit_robust_list()

Mauro Carvalho Chehab (2):
      completion: Drop init_completion define
      refcount: Fix a kernel-doc markup

Peter Zijlstra (7):
      lockdep/selftests: Fix PROVE_RAW_LOCK_NESTING
      seqlock: Rename __seqprop() users
      atomic: Delete obsolete documentation
      atomic: Update MAINTAINERS
      locking/rwsem: Better collate rwsem_read_trylock()
      locking/rwsem: Introduce rwsem_write_trylock()
      locking/rwsem: Fold __down_{read,write}*()

Waiman Long (4):
      locking/rwsem: Pass the current atomic count to rwsem_down_read_slowpath()
      locking/rwsem: Prevent potential lock starvation
      locking/rwsem: Enable reader optimistic lock stealing
      locking/rwsem: Remove reader optimistic spinning


 Documentation/core-api/atomic_ops.rst | 664 ----------------------------------
 Documentation/locking/seqlock.rst     |  21 +-
 MAINTAINERS                           |   2 +
 include/linux/completion.h            |   5 +-
 include/linux/refcount.h              |   2 +-
 include/linux/rwsem.h                 |   3 +
 include/linux/seqlock.h               | 121 ++++---
 kernel/futex.c                        |   2 -
 kernel/locking/lock_events_list.h     |   6 +-
 kernel/locking/rwsem.c                | 383 +++++++-------------
 lib/locking-selftest.c                |  51 ++-
 11 files changed, 253 insertions(+), 1007 deletions(-)
 delete mode 100644 Documentation/core-api/atomic_ops.rst

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
deleted file mode 100644
index 724583453e1f..000000000000
--- a/Documentation/core-api/atomic_ops.rst
+++ /dev/null
@@ -1,664 +0,0 @@
-=======================================================
-Semantics and Behavior of Atomic and Bitmask Operations
-=======================================================
-
-:Author: David S. Miller
-
-This document is intended to serve as a guide to Linux port
-maintainers on how to implement atomic counter, bitops, and spinlock
-interfaces properly.
-
-Atomic Type And Operations
-==========================
-
-The atomic_t type should be defined as a signed integer and
-the atomic_long_t type as a signed long integer.  Also, they should
-be made opaque such that any kind of cast to a normal C integer type
-will fail.  Something like the following should suffice::
-
-	typedef struct { int counter; } atomic_t;
-	typedef struct { long counter; } atomic_long_t;
-
-Historically, counter has been declared volatile.  This is now discouraged.
-See :ref:`Documentation/process/volatile-considered-harmful.rst
-<volatile_considered_harmful>` for the complete rationale.
-
-local_t is very similar to atomic_t. If the counter is per CPU and only
-updated by one CPU, local_t is probably more appropriate. Please see
-:ref:`Documentation/core-api/local_ops.rst <local_ops>` for the semantics of
-local_t.
-
-The first operations to implement for atomic_t's are the initializers and
-plain writes. ::
-
-	#define ATOMIC_INIT(i)		{ (i) }
-	#define atomic_set(v, i)	((v)->counter = (i))
-
-The first macro is used in definitions, such as::
-
-	static atomic_t my_counter = ATOMIC_INIT(1);
-
-The initializer is atomic in that the return values of the atomic operations
-are guaranteed to be correct reflecting the initialized value if the
-initializer is used before runtime.  If the initializer is used at runtime, a
-proper implicit or explicit read memory barrier is needed before reading the
-value with atomic_read from another thread.
-
-As with all of the ``atomic_`` interfaces, replace the leading ``atomic_``
-with ``atomic_long_`` to operate on atomic_long_t.
-
-The second interface can be used at runtime, as in::
-
-	struct foo { atomic_t counter; };
-	...
-
-	struct foo *k;
-
-	k = kmalloc(sizeof(*k), GFP_KERNEL);
-	if (!k)
-		return -ENOMEM;
-	atomic_set(&k->counter, 0);
-
-The setting is atomic in that the return values of the atomic operations by
-all threads are guaranteed to be correct reflecting either the value that has
-been set with this operation or set with another operation.  A proper implicit
-or explicit memory barrier is needed before the value set with the operation
-is guaranteed to be readable with atomic_read from another thread.
-
-Next, we have::
-
-	#define atomic_read(v)	((v)->counter)
-
-which simply reads the counter value currently visible to the calling thread.
-The read is atomic in that the return value is guaranteed to be one of the
-values initialized or modified with the interface operations if a proper
-implicit or explicit memory barrier is used after possible runtime
-initialization by any other thread and the value is modified only with the
-interface operations.  atomic_read does not guarantee that the runtime
-initialization by any other thread is visible yet, so the user of the
-interface must take care of that with a proper implicit or explicit memory
-barrier.
-
-.. warning::
-
-	``atomic_read()`` and ``atomic_set()`` DO NOT IMPLY BARRIERS!
-
-	Some architectures may choose to use the volatile keyword, barriers, or
-	inline assembly to guarantee some degree of immediacy for atomic_read()
-	and atomic_set().  This is not uniformly guaranteed, and may change in
-	the future, so all users of atomic_t should treat atomic_read() and
-	atomic_set() as simple C statements that may be reordered or optimized
-	away entirely by the compiler or processor, and explicitly invoke the
-	appropriate compiler and/or memory barrier for each use case.  Failure
-	to do so will result in code that may suddenly break when used with
-	different architectures or compiler optimizations, or even changes in
-	unrelated code which changes how the compiler optimizes the section
-	accessing atomic_t variables.
-
-Properly aligned pointers, longs, ints, and chars (and unsigned
-equivalents) may be atomically loaded from and stored to in the same
-sense as described for atomic_read() and atomic_set().  The READ_ONCE()
-and WRITE_ONCE() macros should be used to prevent the compiler from using
-optimizations that might otherwise optimize accesses out of existence on
-the one hand, or that might create unsolicited accesses on the other.
-
-For example consider the following code::
-
-	while (a > 0)
-		do_something();
-
-If the compiler can prove that do_something() does not store to the
-variable a, then the compiler is within its rights transforming this to
-the following::
-
-	if (a > 0)
-		for (;;)
-			do_something();
-
-If you don't want the compiler to do this (and you probably don't), then
-you should use something like the following::
-
-	while (READ_ONCE(a) > 0)
-		do_something();
-
-Alternatively, you could place a barrier() call in the loop.
-
-For another example, consider the following code::
-
-	tmp_a = a;
-	do_something_with(tmp_a);
-	do_something_else_with(tmp_a);
-
-If the compiler can prove that do_something_with() does not store to the
-variable a, then the compiler is within its rights to manufacture an
-additional load as follows::
-
-	tmp_a = a;
-	do_something_with(tmp_a);
-	tmp_a = a;
-	do_something_else_with(tmp_a);
-
-This could fatally confuse your code if it expected the same value
-to be passed to do_something_with() and do_something_else_with().
-
-The compiler would be likely to manufacture this additional load if
-do_something_with() was an inline function that made very heavy use
-of registers: reloading from variable a could save a flush to the
-stack and later reload.  To prevent the compiler from attacking your
-code in this manner, write the following::
-
-	tmp_a = READ_ONCE(a);
-	do_something_with(tmp_a);
-	do_something_else_with(tmp_a);
-
-For a final example, consider the following code, assuming that the
-variable a is set at boot time before the second CPU is brought online
-and never changed later, so that memory barriers are not needed::
-
-	if (a)
-		b = 9;
-	else
-		b = 42;
-
-The compiler is within its rights to manufacture an additional store
-by transforming the above code into the following::
-
-	b = 42;
-	if (a)
-		b = 9;
-
-This could come as a fatal surprise to other code running concurrently
-that expected b to never have the value 42 if a was zero.  To prevent
-the compiler from doing this, write something like::
-
-	if (a)
-		WRITE_ONCE(b, 9);
-	else
-		WRITE_ONCE(b, 42);
-
-Don't even -think- about doing this without proper use of memory barriers,
-locks, or atomic operations if variable a can change at runtime!
-
-.. warning::
-
-	``READ_ONCE()`` OR ``WRITE_ONCE()`` DO NOT IMPLY A BARRIER!
-
-Now, we move onto the atomic operation interfaces typically implemented with
-the help of assembly code. ::
-
-	void atomic_add(int i, atomic_t *v);
-	void atomic_sub(int i, atomic_t *v);
-	void atomic_inc(atomic_t *v);
-	void atomic_dec(atomic_t *v);
-
-These four routines add and subtract integral values to/from the given
-atomic_t value.  The first two routines pass explicit integers by
-which to make the adjustment, whereas the latter two use an implicit
-adjustment value of "1".
-
-One very important aspect of these two routines is that they DO NOT
-require any explicit memory barriers.  They need only perform the
-atomic_t counter update in an SMP safe manner.
-
-Next, we have::
-
-	int atomic_inc_return(atomic_t *v);
-	int atomic_dec_return(atomic_t *v);
-
-These routines add 1 and subtract 1, respectively, from the given
-atomic_t and return the new counter value after the operation is
-performed.
-
-Unlike the above routines, it is required that these primitives
-include explicit memory barriers that are performed before and after
-the operation.  It must be done such that all memory operations before
-and after the atomic operation calls are strongly ordered with respect
-to the atomic operation itself.
-
-For example, it should behave as if a smp_mb() call existed both
-before and after the atomic operation.
-
-If the atomic instructions used in an implementation provide explicit
-memory barrier semantics which satisfy the above requirements, that is
-fine as well.
-
-Let's move on::
-
-	int atomic_add_return(int i, atomic_t *v);
-	int atomic_sub_return(int i, atomic_t *v);
-
-These behave just like atomic_{inc,dec}_return() except that an
-explicit counter adjustment is given instead of the implicit "1".
-This means that like atomic_{inc,dec}_return(), the memory barrier
-semantics are required.
-
-Next::
-
-	int atomic_inc_and_test(atomic_t *v);
-	int atomic_dec_and_test(atomic_t *v);
-
-These two routines increment and decrement by 1, respectively, the
-given atomic counter.  They return a boolean indicating whether the
-resulting counter value was zero or not.
-
-Again, these primitives provide explicit memory barrier semantics around
-the atomic operation::
-
-	int atomic_sub_and_test(int i, atomic_t *v);
-
-This is identical to atomic_dec_and_test() except that an explicit
-decrement is given instead of the implicit "1".  This primitive must
-provide explicit memory barrier semantics around the operation::
-
-	int atomic_add_negative(int i, atomic_t *v);
-
-The given increment is added to the given atomic counter value.  A boolean
-is return which indicates whether the resulting counter value is negative.
-This primitive must provide explicit memory barrier semantics around
-the operation.
-
-Then::
-
-	int atomic_xchg(atomic_t *v, int new);
-
-This performs an atomic exchange operation on the atomic variable v, setting
-the given new value.  It returns the old value that the atomic variable v had
-just before the operation.
-
-atomic_xchg must provide explicit memory barriers around the operation. ::
-
-	int atomic_cmpxchg(atomic_t *v, int old, int new);
-
-This performs an atomic compare exchange operation on the atomic value v,
-with the given old and new values. Like all atomic_xxx operations,
-atomic_cmpxchg will only satisfy its atomicity semantics as long as all
-other accesses of \*v are performed through atomic_xxx operations.
-
-atomic_cmpxchg must provide explicit memory barriers around the operation,
-although if the comparison fails then no memory ordering guarantees are
-required.
-
-The semantics for atomic_cmpxchg are the same as those defined for 'cas'
-below.
-
-Finally::
-
-	int atomic_add_unless(atomic_t *v, int a, int u);
-
-If the atomic value v is not equal to u, this function adds a to v, and
-returns non zero. If v is equal to u then it returns zero. This is done as
-an atomic operation.
-
-atomic_add_unless must provide explicit memory barriers around the
-operation unless it fails (returns 0).
-
-atomic_inc_not_zero, equivalent to atomic_add_unless(v, 1, 0)
-
-
-If a caller requires memory barrier semantics around an atomic_t
-operation which does not return a value, a set of interfaces are
-defined which accomplish this::
-
-	void smp_mb__before_atomic(void);
-	void smp_mb__after_atomic(void);
-
-Preceding a non-value-returning read-modify-write atomic operation with
-smp_mb__before_atomic() and following it with smp_mb__after_atomic()
-provides the same full ordering that is provided by value-returning
-read-modify-write atomic operations.
-
-For example, smp_mb__before_atomic() can be used like so::
-
-	obj->dead = 1;
-	smp_mb__before_atomic();
-	atomic_dec(&obj->ref_count);
-
-It makes sure that all memory operations preceding the atomic_dec()
-call are strongly ordered with respect to the atomic counter
-operation.  In the above example, it guarantees that the assignment of
-"1" to obj->dead will be globally visible to other cpus before the
-atomic counter decrement.
-
-Without the explicit smp_mb__before_atomic() call, the
-implementation could legally allow the atomic counter update visible
-to other cpus before the "obj->dead = 1;" assignment.
-
-A missing memory barrier in the cases where they are required by the
-atomic_t implementation above can have disastrous results.  Here is
-an example, which follows a pattern occurring frequently in the Linux
-kernel.  It is the use of atomic counters to implement reference
-counting, and it works such that once the counter falls to zero it can
-be guaranteed that no other entity can be accessing the object::
-
-	static void obj_list_add(struct obj *obj, struct list_head *head)
-	{
-		obj->active = 1;
-		list_add(&obj->list, head);
-	}
-
-	static void obj_list_del(struct obj *obj)
-	{
-		list_del(&obj->list);
-		obj->active = 0;
-	}
-
-	static void obj_destroy(struct obj *obj)
-	{
-		BUG_ON(obj->active);
-		kfree(obj);
-	}
-
-	struct obj *obj_list_peek(struct list_head *head)
-	{
-		if (!list_empty(head)) {
-			struct obj *obj;
-
-			obj = list_entry(head->next, struct obj, list);
-			atomic_inc(&obj->refcnt);
-			return obj;
-		}
-		return NULL;
-	}
-
-	void obj_poke(void)
-	{
-		struct obj *obj;
-
-		spin_lock(&global_list_lock);
-		obj = obj_list_peek(&global_list);
-		spin_unlock(&global_list_lock);
-
-		if (obj) {
-			obj->ops->poke(obj);
-			if (atomic_dec_and_test(&obj->refcnt))
-				obj_destroy(obj);
-		}
-	}
-
-	void obj_timeout(struct obj *obj)
-	{
-		spin_lock(&global_list_lock);
-		obj_list_del(obj);
-		spin_unlock(&global_list_lock);
-
-		if (atomic_dec_and_test(&obj->refcnt))
-			obj_destroy(obj);
-	}
-
-.. note::
-
-	This is a simplification of the ARP queue management in the generic
-	neighbour discover code of the networking.  Olaf Kirch found a bug wrt.
-	memory barriers in kfree_skb() that exposed the atomic_t memory barrier
-	requirements quite clearly.
-
-Given the above scheme, it must be the case that the obj->active
-update done by the obj list deletion be visible to other processors
-before the atomic counter decrement is performed.
-
-Otherwise, the counter could fall to zero, yet obj->active would still
-be set, thus triggering the assertion in obj_destroy().  The error
-sequence looks like this::
-
-	cpu 0				cpu 1
-	obj_poke()			obj_timeout()
-	obj = obj_list_peek();
-	... gains ref to obj, refcnt=2
-					obj_list_del(obj);
-					obj->active = 0 ...
-					... visibility delayed ...
-					atomic_dec_and_test()
-					... refcnt drops to 1 ...
-	atomic_dec_and_test()
-	... refcount drops to 0 ...
-	obj_destroy()
-	BUG() triggers since obj->active
-	still seen as one
-					obj->active update visibility occurs
-
-With the memory barrier semantics required of the atomic_t operations
-which return values, the above sequence of memory visibility can never
-happen.  Specifically, in the above case the atomic_dec_and_test()
-counter decrement would not become globally visible until the
-obj->active update does.
-
-As a historical note, 32-bit Sparc used to only allow usage of
-24-bits of its atomic_t type.  This was because it used 8 bits
-as a spinlock for SMP safety.  Sparc32 lacked a "compare and swap"
-type instruction.  However, 32-bit Sparc has since been moved over
-to a "hash table of spinlocks" scheme, that allows the full 32-bit
-counter to be realized.  Essentially, an array of spinlocks are
-indexed into based upon the address of the atomic_t being operated
-on, and that lock protects the atomic operation.  Parisc uses the
-same scheme.
-
-Another note is that the atomic_t operations returning values are
-extremely slow on an old 386.
-
-
-Atomic Bitmask
-==============
-
-We will now cover the atomic bitmask operations.  You will find that
-their SMP and memory barrier semantics are similar in shape and scope
-to the atomic_t ops above.
-
-Native atomic bit operations are defined to operate on objects aligned
-to the size of an "unsigned long" C data type, and are least of that
-size.  The endianness of the bits within each "unsigned long" are the
-native endianness of the cpu. ::
-
-	void set_bit(unsigned long nr, volatile unsigned long *addr);
-	void clear_bit(unsigned long nr, volatile unsigned long *addr);
-	void change_bit(unsigned long nr, volatile unsigned long *addr);
-
-These routines set, clear, and change, respectively, the bit number
-indicated by "nr" on the bit mask pointed to by "ADDR".
-
-They must execute atomically, yet there are no implicit memory barrier
-semantics required of these interfaces. ::
-
-	int test_and_set_bit(unsigned long nr, volatile unsigned long *addr);
-	int test_and_clear_bit(unsigned long nr, volatile unsigned long *addr);
-	int test_and_change_bit(unsigned long nr, volatile unsigned long *addr);
-
-Like the above, except that these routines return a boolean which
-indicates whether the changed bit was set _BEFORE_ the atomic bit
-operation.
-
-
-.. warning::
-        It is incredibly important that the value be a boolean, ie. "0" or "1".
-        Do not try to be fancy and save a few instructions by declaring the
-        above to return "long" and just returning something like "old_val &
-        mask" because that will not work.
-
-For one thing, this return value gets truncated to int in many code
-paths using these interfaces, so on 64-bit if the bit is set in the
-upper 32-bits then testers will never see that.
-
-One great example of where this problem crops up are the thread_info
-flag operations.  Routines such as test_and_set_ti_thread_flag() chop
-the return value into an int.  There are other places where things
-like this occur as well.
-
-These routines, like the atomic_t counter operations returning values,
-must provide explicit memory barrier semantics around their execution.
-All memory operations before the atomic bit operation call must be
-made visible globally before the atomic bit operation is made visible.
-Likewise, the atomic bit operation must be visible globally before any
-subsequent memory operation is made visible.  For example::
-
-	obj->dead = 1;
-	if (test_and_set_bit(0, &obj->flags))
-		/* ... */;
-	obj->killed = 1;
-
-The implementation of test_and_set_bit() must guarantee that
-"obj->dead = 1;" is visible to cpus before the atomic memory operation
-done by test_and_set_bit() becomes visible.  Likewise, the atomic
-memory operation done by test_and_set_bit() must become visible before
-"obj->killed = 1;" is visible.
-
-Finally there is the basic operation::
-
-	int test_bit(unsigned long nr, __const__ volatile unsigned long *addr);
-
-Which returns a boolean indicating if bit "nr" is set in the bitmask
-pointed to by "addr".
-
-If explicit memory barriers are required around {set,clear}_bit() (which do
-not return a value, and thus does not need to provide memory barrier
-semantics), two interfaces are provided::
-
-	void smp_mb__before_atomic(void);
-	void smp_mb__after_atomic(void);
-
-They are used as follows, and are akin to their atomic_t operation
-brothers::
-
-	/* All memory operations before this call will
-	 * be globally visible before the clear_bit().
-	 */
-	smp_mb__before_atomic();
-	clear_bit( ... );
-
-	/* The clear_bit() will be visible before all
-	 * subsequent memory operations.
-	 */
-	 smp_mb__after_atomic();
-
-There are two special bitops with lock barrier semantics (acquire/release,
-same as spinlocks). These operate in the same way as their non-_lock/unlock
-postfixed variants, except that they are to provide acquire/release semantics,
-respectively. This means they can be used for bit_spin_trylock and
-bit_spin_unlock type operations without specifying any more barriers. ::
-
-	int test_and_set_bit_lock(unsigned long nr, unsigned long *addr);
-	void clear_bit_unlock(unsigned long nr, unsigned long *addr);
-	void __clear_bit_unlock(unsigned long nr, unsigned long *addr);
-
-The __clear_bit_unlock version is non-atomic, however it still implements
-unlock barrier semantics. This can be useful if the lock itself is protecting
-the other bits in the word.
-
-Finally, there are non-atomic versions of the bitmask operations
-provided.  They are used in contexts where some other higher-level SMP
-locking scheme is being used to protect the bitmask, and thus less
-expensive non-atomic operations may be used in the implementation.
-They have names similar to the above bitmask operation interfaces,
-except that two underscores are prefixed to the interface name. ::
-
-	void __set_bit(unsigned long nr, volatile unsigned long *addr);
-	void __clear_bit(unsigned long nr, volatile unsigned long *addr);
-	void __change_bit(unsigned long nr, volatile unsigned long *addr);
-	int __test_and_set_bit(unsigned long nr, volatile unsigned long *addr);
-	int __test_and_clear_bit(unsigned long nr, volatile unsigned long *addr);
-	int __test_and_change_bit(unsigned long nr, volatile unsigned long *addr);
-
-These non-atomic variants also do not require any special memory
-barrier semantics.
-
-The routines xchg() and cmpxchg() must provide the same exact
-memory-barrier semantics as the atomic and bit operations returning
-values.
-
-.. note::
-
-	If someone wants to use xchg(), cmpxchg() and their variants,
-	linux/atomic.h should be included rather than asm/cmpxchg.h, unless the
-	code is in arch/* and can take care of itself.
-
-Spinlocks and rwlocks have memory barrier expectations as well.
-The rule to follow is simple:
-
-1) When acquiring a lock, the implementation must make it globally
-   visible before any subsequent memory operation.
-
-2) When releasing a lock, the implementation must make it such that
-   all previous memory operations are globally visible before the
-   lock release.
-
-Which finally brings us to _atomic_dec_and_lock().  There is an
-architecture-neutral version implemented in lib/dec_and_lock.c,
-but most platforms will wish to optimize this in assembler. ::
-
-	int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
-
-Atomically decrement the given counter, and if will drop to zero
-atomically acquire the given spinlock and perform the decrement
-of the counter to zero.  If it does not drop to zero, do nothing
-with the spinlock.
-
-It is actually pretty simple to get the memory barrier correct.
-Simply satisfy the spinlock grab requirements, which is make
-sure the spinlock operation is globally visible before any
-subsequent memory operation.
-
-We can demonstrate this operation more clearly if we define
-an abstract atomic operation::
-
-	long cas(long *mem, long old, long new);
-
-"cas" stands for "compare and swap".  It atomically:
-
-1) Compares "old" with the value currently at "mem".
-2) If they are equal, "new" is written to "mem".
-3) Regardless, the current value at "mem" is returned.
-
-As an example usage, here is what an atomic counter update
-might look like::
-
-	void example_atomic_inc(long *counter)
-	{
-		long old, new, ret;
-
-		while (1) {
-			old = *counter;
-			new = old + 1;
-
-			ret = cas(counter, old, new);
-			if (ret == old)
-				break;
-		}
-	}
-
-Let's use cas() in order to build a pseudo-C atomic_dec_and_lock()::
-
-	int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
-	{
-		long old, new, ret;
-		int went_to_zero;
-
-		went_to_zero = 0;
-		while (1) {
-			old = atomic_read(atomic);
-			new = old - 1;
-			if (new == 0) {
-				went_to_zero = 1;
-				spin_lock(lock);
-			}
-			ret = cas(atomic, old, new);
-			if (ret == old)
-				break;
-			if (went_to_zero) {
-				spin_unlock(lock);
-				went_to_zero = 0;
-			}
-		}
-
-		return went_to_zero;
-	}
-
-Now, as far as memory barriers go, as long as spin_lock()
-strictly orders all subsequent memory operations (including
-the cas()) with respect to itself, things will be fine.
-
-Said another way, _atomic_dec_and_lock() must guarantee that
-a counter dropping to zero is never made visible before the
-spinlock being acquired.
-
-.. note::
-
-	Note that this also means that for the case where the counter is not
-	dropping to zero, there are no memory ordering requirements.
diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index a334b584f2b3..64405e5da63e 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -89,7 +89,7 @@ Read path::
 
 .. _seqcount_locktype_t:
 
-Sequence counters with associated locks (``seqcount_LOCKTYPE_t``)
+Sequence counters with associated locks (``seqcount_LOCKNAME_t``)
 -----------------------------------------------------------------
 
 As discussed at :ref:`seqcount_t`, sequence count write side critical
@@ -115,27 +115,26 @@ The following sequence counters with associated locks are defined:
   - ``seqcount_mutex_t``
   - ``seqcount_ww_mutex_t``
 
-The plain seqcount read and write APIs branch out to the specific
-seqcount_LOCKTYPE_t implementation at compile-time. This avoids kernel
-API explosion per each new seqcount LOCKTYPE.
+The sequence counter read and write APIs can take either a plain
+seqcount_t or any of the seqcount_LOCKNAME_t variants above.
 
-Initialization (replace "LOCKTYPE" with one of the supported locks)::
+Initialization (replace "LOCKNAME" with one of the supported locks)::
 
 	/* dynamic */
-	seqcount_LOCKTYPE_t foo_seqcount;
-	seqcount_LOCKTYPE_init(&foo_seqcount, &lock);
+	seqcount_LOCKNAME_t foo_seqcount;
+	seqcount_LOCKNAME_init(&foo_seqcount, &lock);
 
 	/* static */
-	static seqcount_LOCKTYPE_t foo_seqcount =
-		SEQCNT_LOCKTYPE_ZERO(foo_seqcount, &lock);
+	static seqcount_LOCKNAME_t foo_seqcount =
+		SEQCNT_LOCKNAME_ZERO(foo_seqcount, &lock);
 
 	/* C99 struct init */
 	struct {
-		.seq   = SEQCNT_LOCKTYPE_ZERO(foo.seq, &lock),
+		.seq   = SEQCNT_LOCKNAME_ZERO(foo.seq, &lock),
 	} foo;
 
 Write path: same as in :ref:`seqcount_t`, while running from a context
-with the associated LOCKTYPE lock acquired.
+with the associated write serialization lock acquired.
 
 Read path: same as in :ref:`seqcount_t`.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 2daa6ee673f7..4ba045a0ad25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2973,6 +2973,8 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
+F:	include/linux/refcount.h
+F:	Documentation/atomic_*.txt
 F:	scripts/atomic/
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
diff --git a/include/linux/completion.h b/include/linux/completion.h
index bf8e77001f18..51d9ab079629 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -28,8 +28,7 @@ struct completion {
 	struct swait_queue_head wait;
 };
 
-#define init_completion_map(x, m) __init_completion(x)
-#define init_completion(x) __init_completion(x)
+#define init_completion_map(x, m) init_completion(x)
 static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
 
@@ -82,7 +81,7 @@ static inline void complete_release(struct completion *x) {}
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void __init_completion(struct completion *x)
+static inline void init_completion(struct completion *x)
 {
 	x->done = 0;
 	init_swait_queue_head(&x->wait);
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 497990c69b0b..b8a6e387f8f9 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -101,7 +101,7 @@
 struct mutex;
 
 /**
- * struct refcount_t - variant of atomic_t specialized for reference counts
+ * typedef refcount_t - variant of atomic_t specialized for reference counts
  * @refs: atomic_t counter field
  *
  * The counter saturates at REFCOUNT_SATURATED and will not move once
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 25e3fde85617..4c715be48717 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -123,6 +123,7 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
  * lock for reading
  */
 extern void down_read(struct rw_semaphore *sem);
+extern int __must_check down_read_interruptible(struct rw_semaphore *sem);
 extern int __must_check down_read_killable(struct rw_semaphore *sem);
 
 /*
@@ -171,6 +172,7 @@ extern void downgrade_write(struct rw_semaphore *sem);
  * See Documentation/locking/lockdep-design.rst for more details.)
  */
 extern void down_read_nested(struct rw_semaphore *sem, int subclass);
+extern int __must_check down_read_killable_nested(struct rw_semaphore *sem, int subclass);
 extern void down_write_nested(struct rw_semaphore *sem, int subclass);
 extern int down_write_killable_nested(struct rw_semaphore *sem, int subclass);
 extern void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest_lock);
@@ -191,6 +193,7 @@ extern void down_read_non_owner(struct rw_semaphore *sem);
 extern void up_read_non_owner(struct rw_semaphore *sem);
 #else
 # define down_read_nested(sem, subclass)		down_read(sem)
+# define down_read_killable_nested(sem, subclass)	down_read_killable(sem)
 # define down_write_nest_lock(sem, nest_lock)	down_write(sem)
 # define down_write_nested(sem, subclass)	down_write(sem)
 # define down_write_killable_nested(sem, subclass)	down_write_killable(sem)
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index cbfc78b92b65..2f7bb92b4c9e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -307,10 +307,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 	__seqprop_case((s),	mutex,		prop),			\
 	__seqprop_case((s),	ww_mutex,	prop))
 
-#define __seqcount_ptr(s)		__seqprop(s, ptr)
-#define __seqcount_sequence(s)		__seqprop(s, sequence)
-#define __seqcount_lock_preemptible(s)	__seqprop(s, preemptible)
-#define __seqcount_assert_lock_held(s)	__seqprop(s, assert)
+#define seqprop_ptr(s)			__seqprop(s, ptr)
+#define seqprop_sequence(s)		__seqprop(s, sequence)
+#define seqprop_preemptible(s)		__seqprop(s, preemptible)
+#define seqprop_assert(s)		__seqprop(s, assert)
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
@@ -328,13 +328,13 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define __read_seqcount_begin(s)					\
 ({									\
-	unsigned seq;							\
+	unsigned __seq;							\
 									\
-	while ((seq = __seqcount_sequence(s)) & 1)			\
+	while ((__seq = seqprop_sequence(s)) & 1)			\
 		cpu_relax();						\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	seq;								\
+	__seq;								\
 })
 
 /**
@@ -345,10 +345,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount_begin(s)					\
 ({									\
-	unsigned seq = __read_seqcount_begin(s);			\
+	unsigned _seq = __read_seqcount_begin(s);			\
 									\
 	smp_rmb();							\
-	seq;								\
+	_seq;								\
 })
 
 /**
@@ -359,7 +359,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define read_seqcount_begin(s)						\
 ({									\
-	seqcount_lockdep_reader_access(__seqcount_ptr(s));		\
+	seqcount_lockdep_reader_access(seqprop_ptr(s));			\
 	raw_read_seqcount_begin(s);					\
 })
 
@@ -376,11 +376,11 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount(s)						\
 ({									\
-	unsigned seq = __seqcount_sequence(s);				\
+	unsigned __seq = seqprop_sequence(s);				\
 									\
 	smp_rmb();							\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	seq;								\
+	__seq;								\
 })
 
 /**
@@ -425,9 +425,9 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	__read_seqcount_t_retry(__seqcount_ptr(s), start)
+	do___read_seqcount_retry(seqprop_ptr(s), start)
 
-static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
+static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	kcsan_atomic_next(0);
 	return unlikely(READ_ONCE(s->sequence) != start);
@@ -445,27 +445,29 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	read_seqcount_t_retry(__seqcount_ptr(s), start)
+	do_read_seqcount_retry(seqprop_ptr(s), start)
 
-static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
+static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	smp_rmb();
-	return __read_seqcount_t_retry(s, start);
+	return do___read_seqcount_retry(s, start);
 }
 
 /**
  * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ *
+ * Context: check write_seqcount_begin()
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
+	do_raw_write_seqcount_begin(seqprop_ptr(s));			\
 } while (0)
 
-static inline void raw_write_seqcount_t_begin(seqcount_t *s)
+static inline void do_raw_write_seqcount_begin(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -475,16 +477,18 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
 /**
  * raw_write_seqcount_end() - end a seqcount_t write section w/o lockdep
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ *
+ * Context: check write_seqcount_end()
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
-	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
+	do_raw_write_seqcount_end(seqprop_ptr(s));			\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
-static inline void raw_write_seqcount_t_end(seqcount_t *s)
+static inline void do_raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
@@ -498,20 +502,21 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
  * @subclass: lockdep nesting level
  *
  * See Documentation/locking/lockdep-design.rst
+ * Context: check write_seqcount_begin()
  */
 #define write_seqcount_begin_nested(s, subclass)			\
 do {									\
-	__seqcount_assert_lock_held(s);					\
+	seqprop_assert(s);						\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
+	do_write_seqcount_begin_nested(seqprop_ptr(s), subclass);	\
 } while (0)
 
-static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
+static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	raw_write_seqcount_t_begin(s);
+	do_raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
@@ -519,46 +524,46 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
  * write_seqcount_begin() - start a seqcount_t write side critical section
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
- * write_seqcount_begin opens a write side critical section of the given
- * seqcount_t.
- *
- * Context: seqcount_t write side critical sections must be serialized and
- * non-preemptible. If readers can be invoked from hardirq or softirq
+ * Context: sequence counter write side sections must be serialized and
+ * non-preemptible. Preemption will be automatically disabled if and
+ * only if the seqcount write serialization lock is associated, and
+ * preemptible.  If readers can be invoked from hardirq or softirq
  * context, interrupts or bottom halves must be respectively disabled.
  */
 #define write_seqcount_begin(s)						\
 do {									\
-	__seqcount_assert_lock_held(s);					\
+	seqprop_assert(s);						\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin(__seqcount_ptr(s));			\
+	do_write_seqcount_begin(seqprop_ptr(s));			\
 } while (0)
 
-static inline void write_seqcount_t_begin(seqcount_t *s)
+static inline void do_write_seqcount_begin(seqcount_t *s)
 {
-	write_seqcount_t_begin_nested(s, 0);
+	do_write_seqcount_begin_nested(s, 0);
 }
 
 /**
  * write_seqcount_end() - end a seqcount_t write side critical section
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
- * The write section must've been opened with write_seqcount_begin().
+ * Context: Preemption will be automatically re-enabled if and only if
+ * the seqcount write serialization lock is associated, and preemptible.
  */
 #define write_seqcount_end(s)						\
 do {									\
-	write_seqcount_t_end(__seqcount_ptr(s));			\
+	do_write_seqcount_end(seqprop_ptr(s));				\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
-static inline void write_seqcount_t_end(seqcount_t *s)
+static inline void do_write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
-	raw_write_seqcount_t_end(s);
+	do_raw_write_seqcount_end(s);
 }
 
 /**
@@ -603,9 +608,9 @@ static inline void write_seqcount_t_end(seqcount_t *s)
  *      }
  */
 #define raw_write_seqcount_barrier(s)					\
-	raw_write_seqcount_t_barrier(__seqcount_ptr(s))
+	do_raw_write_seqcount_barrier(seqprop_ptr(s))
 
-static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
+static inline void do_raw_write_seqcount_barrier(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -623,9 +628,9 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
  * will complete successfully and see data older than this.
  */
 #define write_seqcount_invalidate(s)					\
-	write_seqcount_t_invalidate(__seqcount_ptr(s))
+	do_write_seqcount_invalidate(seqprop_ptr(s))
 
-static inline void write_seqcount_t_invalidate(seqcount_t *s)
+static inline void do_write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
 	kcsan_nestable_atomic_begin();
@@ -865,9 +870,9 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use write_seqcount_*t*_begin()
- * instead of the generic write_seqcount_begin(). This way, no redundant
- * lockdep_assert_held() checks are added.
+ * For all seqlock_t write side functions, use the the internal
+ * do_write_seqcount_begin() instead of generic write_seqcount_begin().
+ * This way, no redundant lockdep_assert_held() checks are added.
  */
 
 /**
@@ -886,7 +891,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -898,7 +903,7 @@ static inline void write_seqlock(seqlock_t *sl)
  */
 static inline void write_sequnlock(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock(&sl->lock);
 }
 
@@ -912,7 +917,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -925,7 +930,7 @@ static inline void write_seqlock_bh(seqlock_t *sl)
  */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
@@ -939,7 +944,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -951,7 +956,7 @@ static inline void write_seqlock_irq(seqlock_t *sl)
  */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -960,7 +965,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 	return flags;
 }
 
@@ -989,7 +994,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
diff --git a/kernel/futex.c b/kernel/futex.c
index 00259c7e288e..c47d1015d759 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -310,8 +310,6 @@ static inline bool should_fail_futex(bool fshared)
 
 #ifdef CONFIG_COMPAT
 static void compat_exit_robust_list(struct task_struct *curr);
-#else
-static inline void compat_exit_robust_list(struct task_struct *curr) { }
 #endif
 
 /*
diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 239039d0ce21..97fb6f3f840a 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -56,13 +56,11 @@ LOCK_EVENT(rwsem_sleep_reader)	/* # of reader sleeps			*/
 LOCK_EVENT(rwsem_sleep_writer)	/* # of writer sleeps			*/
 LOCK_EVENT(rwsem_wake_reader)	/* # of reader wakeups			*/
 LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
-LOCK_EVENT(rwsem_opt_rlock)	/* # of opt-acquired read locks		*/
-LOCK_EVENT(rwsem_opt_wlock)	/* # of opt-acquired write locks	*/
+LOCK_EVENT(rwsem_opt_lock)	/* # of opt-acquired write locks	*/
 LOCK_EVENT(rwsem_opt_fail)	/* # of failed optspins			*/
 LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled optspins		*/
-LOCK_EVENT(rwsem_opt_norspin)	/* # of disabled reader-only optspins	*/
-LOCK_EVENT(rwsem_opt_rlock2)	/* # of opt-acquired 2ndary read locks	*/
 LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
+LOCK_EVENT(rwsem_rlock_steal)	/* # of read locks by lock stealing	*/
 LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
 LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
 LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f11b9bd3431d..ba67600c7b2c 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -31,19 +31,13 @@
 #include "lock_events.h"
 
 /*
- * The least significant 3 bits of the owner value has the following
+ * The least significant 2 bits of the owner value has the following
  * meanings when set.
  *  - Bit 0: RWSEM_READER_OWNED - The rwsem is owned by readers
- *  - Bit 1: RWSEM_RD_NONSPINNABLE - Readers cannot spin on this lock.
- *  - Bit 2: RWSEM_WR_NONSPINNABLE - Writers cannot spin on this lock.
+ *  - Bit 1: RWSEM_NONSPINNABLE - Cannot spin on a reader-owned lock
  *
- * When the rwsem is either owned by an anonymous writer, or it is
- * reader-owned, but a spinning writer has timed out, both nonspinnable
- * bits will be set to disable optimistic spinning by readers and writers.
- * In the later case, the last unlocking reader should then check the
- * writer nonspinnable bit and clear it only to give writers preference
- * to acquire the lock via optimistic spinning, but not readers. Similar
- * action is also done in the reader slowpath.
+ * When the rwsem is reader-owned and a spinning writer has timed out,
+ * the nonspinnable bit will be set to disable optimistic spinning.
 
  * When a writer acquires a rwsem, it puts its task_struct pointer
  * into the owner field. It is cleared after an unlock.
@@ -59,46 +53,14 @@
  * is involved. Ideally we would like to track all the readers that own
  * a rwsem, but the overhead is simply too big.
  *
- * Reader optimistic spinning is helpful when the reader critical section
- * is short and there aren't that many readers around. It makes readers
- * relatively more preferred than writers. When a writer times out spinning
- * on a reader-owned lock and set the nospinnable bits, there are two main
- * reasons for that.
- *
- *  1) The reader critical section is long, perhaps the task sleeps after
- *     acquiring the read lock.
- *  2) There are just too many readers contending the lock causing it to
- *     take a while to service all of them.
- *
- * In the former case, long reader critical section will impede the progress
- * of writers which is usually more important for system performance. In
- * the later case, reader optimistic spinning tends to make the reader
- * groups that contain readers that acquire the lock together smaller
- * leading to more of them. That may hurt performance in some cases. In
- * other words, the setting of nonspinnable bits indicates that reader
- * optimistic spinning may not be helpful for those workloads that cause
- * it.
- *
- * Therefore, any writers that had observed the setting of the writer
- * nonspinnable bit for a given rwsem after they fail to acquire the lock
- * via optimistic spinning will set the reader nonspinnable bit once they
- * acquire the write lock. Similarly, readers that observe the setting
- * of reader nonspinnable bit at slowpath entry will set the reader
- * nonspinnable bits when they acquire the read lock via the wakeup path.
- *
- * Once the reader nonspinnable bit is on, it will only be reset when
- * a writer is able to acquire the rwsem in the fast path or somehow a
- * reader or writer in the slowpath doesn't observe the nonspinable bit.
- *
- * This is to discourage reader optmistic spinning on that particular
- * rwsem and make writers more preferred. This adaptive disabling of reader
- * optimistic spinning will alleviate the negative side effect of this
- * feature.
+ * A fast path reader optimistic lock stealing is supported when the rwsem
+ * is previously owned by a writer and the following conditions are met:
+ *  - OSQ is empty
+ *  - rwsem is not currently writer owned
+ *  - the handoff isn't set.
  */
 #define RWSEM_READER_OWNED	(1UL << 0)
-#define RWSEM_RD_NONSPINNABLE	(1UL << 1)
-#define RWSEM_WR_NONSPINNABLE	(1UL << 2)
-#define RWSEM_NONSPINNABLE	(RWSEM_RD_NONSPINNABLE | RWSEM_WR_NONSPINNABLE)
+#define RWSEM_NONSPINNABLE	(1UL << 1)
 #define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE)
 
 #ifdef CONFIG_DEBUG_RWSEMS
@@ -203,7 +165,7 @@ static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
 					    struct task_struct *owner)
 {
 	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED |
-		(atomic_long_read(&sem->owner) & RWSEM_RD_NONSPINNABLE);
+		(atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE);
 
 	atomic_long_set(&sem->owner, val);
 }
@@ -270,12 +232,31 @@ static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
 					  owner | RWSEM_NONSPINNABLE));
 }
 
-static inline bool rwsem_read_trylock(struct rw_semaphore *sem)
+static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cntp)
 {
-	long cnt = atomic_long_add_return_acquire(RWSEM_READER_BIAS, &sem->count);
-	if (WARN_ON_ONCE(cnt < 0))
+	*cntp = atomic_long_add_return_acquire(RWSEM_READER_BIAS, &sem->count);
+
+	if (WARN_ON_ONCE(*cntp < 0))
 		rwsem_set_nonspinnable(sem);
-	return !(cnt & RWSEM_READ_FAILED_MASK);
+
+	if (!(*cntp & RWSEM_READ_FAILED_MASK)) {
+		rwsem_set_reader_owned(sem);
+		return true;
+	}
+
+	return false;
+}
+
+static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
+{
+	long tmp = RWSEM_UNLOCKED_VALUE;
+
+	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
+		rwsem_set_owner(sem);
+		return true;
+	}
+
+	return false;
 }
 
 /*
@@ -353,7 +334,6 @@ struct rwsem_waiter {
 	struct task_struct *task;
 	enum rwsem_waiter_type type;
 	unsigned long timeout;
-	unsigned long last_rowner;
 };
 #define rwsem_first_waiter(sem) \
 	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
@@ -467,10 +447,6 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		 * the reader is copied over.
 		 */
 		owner = waiter->task;
-		if (waiter->last_rowner & RWSEM_RD_NONSPINNABLE) {
-			owner = (void *)((unsigned long)owner | RWSEM_RD_NONSPINNABLE);
-			lockevent_inc(rwsem_opt_norspin);
-		}
 		__rwsem_set_reader_owned(sem, owner);
 	}
 
@@ -601,30 +577,6 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 }
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-/*
- * Try to acquire read lock before the reader is put on wait queue.
- * Lock acquisition isn't allowed if the rwsem is locked or a writer handoff
- * is ongoing.
- */
-static inline bool rwsem_try_read_lock_unqueued(struct rw_semaphore *sem)
-{
-	long count = atomic_long_read(&sem->count);
-
-	if (count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))
-		return false;
-
-	count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
-	if (!(count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
-		rwsem_set_reader_owned(sem);
-		lockevent_inc(rwsem_opt_rlock);
-		return true;
-	}
-
-	/* Back out the change */
-	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
-	return false;
-}
-
 /*
  * Try to acquire write lock before the writer has been put on wait queue.
  */
@@ -636,7 +588,7 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
 					count | RWSEM_WRITER_LOCKED)) {
 			rwsem_set_owner(sem);
-			lockevent_inc(rwsem_opt_wlock);
+			lockevent_inc(rwsem_opt_lock);
 			return true;
 		}
 	}
@@ -652,8 +604,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 	return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
 }
 
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
-					   unsigned long nonspinnable)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *owner;
 	unsigned long flags;
@@ -670,7 +621,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 	/*
 	 * Don't check the read-owner as the entry may be stale.
 	 */
-	if ((flags & nonspinnable) ||
+	if ((flags & RWSEM_NONSPINNABLE) ||
 	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
 		ret = false;
 	rcu_read_unlock();
@@ -700,9 +651,9 @@ enum owner_state {
 #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
 
 static inline enum owner_state
-rwsem_owner_state(struct task_struct *owner, unsigned long flags, unsigned long nonspinnable)
+rwsem_owner_state(struct task_struct *owner, unsigned long flags)
 {
-	if (flags & nonspinnable)
+	if (flags & RWSEM_NONSPINNABLE)
 		return OWNER_NONSPINNABLE;
 
 	if (flags & RWSEM_READER_OWNED)
@@ -712,14 +663,14 @@ rwsem_owner_state(struct task_struct *owner, unsigned long flags, unsigned long
 }
 
 static noinline enum owner_state
-rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
+rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	struct task_struct *new, *owner;
 	unsigned long flags, new_flags;
 	enum owner_state state;
 
 	owner = rwsem_owner_flags(sem, &flags);
-	state = rwsem_owner_state(owner, flags, nonspinnable);
+	state = rwsem_owner_state(owner, flags);
 	if (state != OWNER_WRITER)
 		return state;
 
@@ -733,7 +684,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 		 */
 		new = rwsem_owner_flags(sem, &new_flags);
 		if ((new != owner) || (new_flags != flags)) {
-			state = rwsem_owner_state(new, new_flags, nonspinnable);
+			state = rwsem_owner_state(new, new_flags);
 			break;
 		}
 
@@ -782,14 +733,12 @@ static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
 	return sched_clock() + delta;
 }
 
-static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
+static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
 	bool taken = false;
 	int prev_owner_state = OWNER_NULL;
 	int loop = 0;
 	u64 rspin_threshold = 0;
-	unsigned long nonspinnable = wlock ? RWSEM_WR_NONSPINNABLE
-					   : RWSEM_RD_NONSPINNABLE;
 
 	preempt_disable();
 
@@ -806,15 +755,14 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 	for (;;) {
 		enum owner_state owner_state;
 
-		owner_state = rwsem_spin_on_owner(sem, nonspinnable);
+		owner_state = rwsem_spin_on_owner(sem);
 		if (!(owner_state & OWNER_SPINNABLE))
 			break;
 
 		/*
 		 * Try to acquire the lock
 		 */
-		taken = wlock ? rwsem_try_write_lock_unqueued(sem)
-			      : rwsem_try_read_lock_unqueued(sem);
+		taken = rwsem_try_write_lock_unqueued(sem);
 
 		if (taken)
 			break;
@@ -822,7 +770,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 		/*
 		 * Time-based reader-owned rwsem optimistic spinning
 		 */
-		if (wlock && (owner_state == OWNER_READER)) {
+		if (owner_state == OWNER_READER) {
 			/*
 			 * Re-initialize rspin_threshold every time when
 			 * the owner state changes from non-reader to reader.
@@ -831,7 +779,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 			 * the beginning of the 2nd reader phase.
 			 */
 			if (prev_owner_state != OWNER_READER) {
-				if (rwsem_test_oflags(sem, nonspinnable))
+				if (rwsem_test_oflags(sem, RWSEM_NONSPINNABLE))
 					break;
 				rspin_threshold = rwsem_rspin_threshold(sem);
 				loop = 0;
@@ -907,78 +855,30 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
 }
 
 /*
- * Clear the owner's RWSEM_WR_NONSPINNABLE bit if it is set. This should
+ * Clear the owner's RWSEM_NONSPINNABLE bit if it is set. This should
  * only be called when the reader count reaches 0.
- *
- * This give writers better chance to acquire the rwsem first before
- * readers when the rwsem was being held by readers for a relatively long
- * period of time. Race can happen that an optimistic spinner may have
- * just stolen the rwsem and set the owner, but just clearing the
- * RWSEM_WR_NONSPINNABLE bit will do no harm anyway.
  */
-static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
+static inline void clear_nonspinnable(struct rw_semaphore *sem)
 {
-	if (rwsem_test_oflags(sem, RWSEM_WR_NONSPINNABLE))
-		atomic_long_andnot(RWSEM_WR_NONSPINNABLE, &sem->owner);
+	if (rwsem_test_oflags(sem, RWSEM_NONSPINNABLE))
+		atomic_long_andnot(RWSEM_NONSPINNABLE, &sem->owner);
 }
 
-/*
- * This function is called when the reader fails to acquire the lock via
- * optimistic spinning. In this case we will still attempt to do a trylock
- * when comparing the rwsem state right now with the state when entering
- * the slowpath indicates that the reader is still in a valid reader phase.
- * This happens when the following conditions are true:
- *
- * 1) The lock is currently reader owned, and
- * 2) The lock is previously not reader-owned or the last read owner changes.
- *
- * In the former case, we have transitioned from a writer phase to a
- * reader-phase while spinning. In the latter case, it means the reader
- * phase hasn't ended when we entered the optimistic spinning loop. In
- * both cases, the reader is eligible to acquire the lock. This is the
- * secondary path where a read lock is acquired optimistically.
- *
- * The reader non-spinnable bit wasn't set at time of entry or it will
- * not be here at all.
- */
-static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
-					      unsigned long last_rowner)
-{
-	unsigned long owner = atomic_long_read(&sem->owner);
-
-	if (!(owner & RWSEM_READER_OWNED))
-		return false;
-
-	if (((owner ^ last_rowner) & ~RWSEM_OWNER_FLAGS_MASK) &&
-	    rwsem_try_read_lock_unqueued(sem)) {
-		lockevent_inc(rwsem_opt_rlock2);
-		lockevent_add(rwsem_opt_fail, -1);
-		return true;
-	}
-	return false;
-}
 #else
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
-					   unsigned long nonspinnable)
+static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 {
 	return false;
 }
 
-static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
+static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
 	return false;
 }
 
-static inline void clear_wr_nonspinnable(struct rw_semaphore *sem) { }
-
-static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
-					      unsigned long last_rowner)
-{
-	return false;
-}
+static inline void clear_nonspinnable(struct rw_semaphore *sem) { }
 
 static inline int
-rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
+rwsem_spin_on_owner(struct rw_semaphore *sem)
 {
 	return 0;
 }
@@ -989,36 +889,35 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
-rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
+rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, int state)
 {
-	long count, adjustment = -RWSEM_READER_BIAS;
+	long adjustment = -RWSEM_READER_BIAS;
+	long rcnt = (count >> RWSEM_READER_SHIFT);
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 	bool wake = false;
 
 	/*
-	 * Save the current read-owner of rwsem, if available, and the
-	 * reader nonspinnable bit.
+	 * To prevent a constant stream of readers from starving a sleeping
+	 * waiter, don't attempt optimistic lock stealing if the lock is
+	 * currently owned by readers.
 	 */
-	waiter.last_rowner = atomic_long_read(&sem->owner);
-	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
-		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
-
-	if (!rwsem_can_spin_on_owner(sem, RWSEM_RD_NONSPINNABLE))
+	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
+	    (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
 		goto queue;
 
 	/*
-	 * Undo read bias from down_read() and do optimistic spinning.
+	 * Reader optimistic lock stealing.
 	 */
-	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
-	adjustment = 0;
-	if (rwsem_optimistic_spin(sem, false)) {
-		/* rwsem_optimistic_spin() implies ACQUIRE on success */
+	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF))) {
+		rwsem_set_reader_owned(sem);
+		lockevent_inc(rwsem_rlock_steal);
+
 		/*
-		 * Wake up other readers in the wait list if the front
-		 * waiter is a reader.
+		 * Wake up other readers in the wait queue if it is
+		 * the first reader.
 		 */
-		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS)) {
+		if ((rcnt == 1) && (count & RWSEM_FLAG_WAITERS)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (!list_empty(&sem->wait_list))
 				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
@@ -1027,9 +926,6 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 			wake_up_q(&wake_q);
 		}
 		return sem;
-	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
-		/* rwsem_reader_phase_trylock() implies ACQUIRE on success */
-		return sem;
 	}
 
 queue:
@@ -1045,7 +941,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 		 * exit the slowpath and return immediately as its
 		 * RWSEM_READER_BIAS has already been set in the count.
 		 */
-		if (adjustment && !(atomic_long_read(&sem->count) &
+		if (!(atomic_long_read(&sem->count) &
 		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
 			/* Provide lock ACQUIRE */
 			smp_acquire__after_ctrl_dep();
@@ -1059,10 +955,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	list_add_tail(&waiter.list, &sem->wait_list);
 
 	/* we're now waiting on the lock, but no longer actively locking */
-	if (adjustment)
-		count = atomic_long_add_return(adjustment, &sem->count);
-	else
-		count = atomic_long_read(&sem->count);
+	count = atomic_long_add_return(adjustment, &sem->count);
 
 	/*
 	 * If there are no active locks, wake the front queued process(es).
@@ -1071,7 +964,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	 * wake our own waiter to join the existing active readers !
 	 */
 	if (!(count & RWSEM_LOCK_MASK)) {
-		clear_wr_nonspinnable(sem);
+		clear_nonspinnable(sem);
 		wake = true;
 	}
 	if (wake || (!(count & RWSEM_WRITER_MASK) &&
@@ -1116,19 +1009,6 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	return ERR_PTR(-EINTR);
 }
 
-/*
- * This function is called by the a write lock owner. So the owner value
- * won't get changed by others.
- */
-static inline void rwsem_disable_reader_optspin(struct rw_semaphore *sem,
-						bool disable)
-{
-	if (unlikely(disable)) {
-		atomic_long_or(RWSEM_RD_NONSPINNABLE, &sem->owner);
-		lockevent_inc(rwsem_opt_norspin);
-	}
-}
-
 /*
  * Wait until we successfully acquire the write lock
  */
@@ -1136,26 +1016,17 @@ static struct rw_semaphore *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
-	bool disable_rspin;
 	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
-	if (rwsem_can_spin_on_owner(sem, RWSEM_WR_NONSPINNABLE) &&
-	    rwsem_optimistic_spin(sem, true)) {
+	if (rwsem_can_spin_on_owner(sem) && rwsem_optimistic_spin(sem)) {
 		/* rwsem_optimistic_spin() implies ACQUIRE on success */
 		return sem;
 	}
 
-	/*
-	 * Disable reader optimistic spinning for this rwsem after
-	 * acquiring the write lock when the setting of the nonspinnable
-	 * bits are observed.
-	 */
-	disable_rspin = atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE;
-
 	/*
 	 * Optimistic spinning failed, proceed to the slowpath
 	 * and block until we can acquire the sem.
@@ -1224,7 +1095,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		 * without sleeping.
 		 */
 		if (wstate == WRITER_HANDOFF &&
-		    rwsem_spin_on_owner(sem, RWSEM_NONSPINNABLE) == OWNER_NULL)
+		    rwsem_spin_on_owner(sem) == OWNER_NULL)
 			goto trylock_again;
 
 		/* Block until there are no active lockers. */
@@ -1266,7 +1137,6 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	}
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
-	rwsem_disable_reader_optspin(sem, disable_rspin);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
 
@@ -1335,26 +1205,31 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-static inline void __down_read(struct rw_semaphore *sem)
+static inline int __down_read_common(struct rw_semaphore *sem, int state)
 {
-	if (!rwsem_read_trylock(sem)) {
-		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
+	long count;
+
+	if (!rwsem_read_trylock(sem, &count)) {
+		if (IS_ERR(rwsem_down_read_slowpath(sem, count, state)))
+			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
-	} else {
-		rwsem_set_reader_owned(sem);
 	}
+	return 0;
+}
+
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	__down_read_common(sem, TASK_UNINTERRUPTIBLE);
+}
+
+static inline int __down_read_interruptible(struct rw_semaphore *sem)
+{
+	return __down_read_common(sem, TASK_INTERRUPTIBLE);
 }
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	if (!rwsem_read_trylock(sem)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
-			return -EINTR;
-		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
-	} else {
-		rwsem_set_reader_owned(sem);
-	}
-	return 0;
+	return __down_read_common(sem, TASK_KILLABLE);
 }
 
 static inline int __down_read_trylock(struct rw_semaphore *sem)
@@ -1380,44 +1255,30 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
+static inline int __down_write_common(struct rw_semaphore *sem, int state)
 {
-	long tmp = RWSEM_UNLOCKED_VALUE;
+	if (unlikely(!rwsem_write_trylock(sem))) {
+		if (IS_ERR(rwsem_down_write_slowpath(sem, state)))
+			return -EINTR;
+	}
 
-	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-						      RWSEM_WRITER_LOCKED)))
-		rwsem_down_write_slowpath(sem, TASK_UNINTERRUPTIBLE);
-	else
-		rwsem_set_owner(sem);
+	return 0;
 }
 
-static inline int __down_write_killable(struct rw_semaphore *sem)
+static inline void __down_write(struct rw_semaphore *sem)
 {
-	long tmp = RWSEM_UNLOCKED_VALUE;
+	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
+}
 
-	if (unlikely(!atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-						      RWSEM_WRITER_LOCKED))) {
-		if (IS_ERR(rwsem_down_write_slowpath(sem, TASK_KILLABLE)))
-			return -EINTR;
-	} else {
-		rwsem_set_owner(sem);
-	}
-	return 0;
+static inline int __down_write_killable(struct rw_semaphore *sem)
+{
+	return __down_write_common(sem, TASK_KILLABLE);
 }
 
 static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
-	long tmp;
-
 	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
-
-	tmp  = RWSEM_UNLOCKED_VALUE;
-	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-					    RWSEM_WRITER_LOCKED)) {
-		rwsem_set_owner(sem);
-		return true;
-	}
-	return false;
+	return rwsem_write_trylock(sem);
 }
 
 /*
@@ -1435,7 +1296,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
 		      RWSEM_FLAG_WAITERS)) {
-		clear_wr_nonspinnable(sem);
+		clear_nonspinnable(sem);
 		rwsem_wake(sem, tmp);
 	}
 }
@@ -1495,6 +1356,20 @@ void __sched down_read(struct rw_semaphore *sem)
 }
 EXPORT_SYMBOL(down_read);
 
+int __sched down_read_interruptible(struct rw_semaphore *sem)
+{
+	might_sleep();
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
+
+	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_interruptible)) {
+		rwsem_release(&sem->dep_map, _RET_IP_);
+		return -EINTR;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(down_read_interruptible);
+
 int __sched down_read_killable(struct rw_semaphore *sem)
 {
 	might_sleep();
@@ -1605,6 +1480,20 @@ void down_read_nested(struct rw_semaphore *sem, int subclass)
 }
 EXPORT_SYMBOL(down_read_nested);
 
+int down_read_killable_nested(struct rw_semaphore *sem, int subclass)
+{
+	might_sleep();
+	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
+
+	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_killable)) {
+		rwsem_release(&sem->dep_map, _RET_IP_);
+		return -EINTR;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(down_read_killable_nested);
+
 void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
 {
 	might_sleep();
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index a899b3f0e2e5..4c24ac8a456c 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -58,10 +58,10 @@ static struct ww_mutex o, o2, o3;
  * Normal standalone locks, for the circular and irq-context
  * dependency tests:
  */
-static DEFINE_RAW_SPINLOCK(lock_A);
-static DEFINE_RAW_SPINLOCK(lock_B);
-static DEFINE_RAW_SPINLOCK(lock_C);
-static DEFINE_RAW_SPINLOCK(lock_D);
+static DEFINE_SPINLOCK(lock_A);
+static DEFINE_SPINLOCK(lock_B);
+static DEFINE_SPINLOCK(lock_C);
+static DEFINE_SPINLOCK(lock_D);
 
 static DEFINE_RWLOCK(rwlock_A);
 static DEFINE_RWLOCK(rwlock_B);
@@ -93,12 +93,12 @@ static DEFINE_RT_MUTEX(rtmutex_D);
  * but X* and Y* are different classes. We do this so that
  * we do not trigger a real lockup:
  */
-static DEFINE_RAW_SPINLOCK(lock_X1);
-static DEFINE_RAW_SPINLOCK(lock_X2);
-static DEFINE_RAW_SPINLOCK(lock_Y1);
-static DEFINE_RAW_SPINLOCK(lock_Y2);
-static DEFINE_RAW_SPINLOCK(lock_Z1);
-static DEFINE_RAW_SPINLOCK(lock_Z2);
+static DEFINE_SPINLOCK(lock_X1);
+static DEFINE_SPINLOCK(lock_X2);
+static DEFINE_SPINLOCK(lock_Y1);
+static DEFINE_SPINLOCK(lock_Y2);
+static DEFINE_SPINLOCK(lock_Z1);
+static DEFINE_SPINLOCK(lock_Z2);
 
 static DEFINE_RWLOCK(rwlock_X1);
 static DEFINE_RWLOCK(rwlock_X2);
@@ -138,10 +138,10 @@ static DEFINE_RT_MUTEX(rtmutex_Z2);
  */
 #define INIT_CLASS_FUNC(class) 				\
 static noinline void					\
-init_class_##class(raw_spinlock_t *lock, rwlock_t *rwlock, \
+init_class_##class(spinlock_t *lock, rwlock_t *rwlock, \
 	struct mutex *mutex, struct rw_semaphore *rwsem)\
 {							\
-	raw_spin_lock_init(lock);			\
+	spin_lock_init(lock);			\
 	rwlock_init(rwlock);				\
 	mutex_init(mutex);				\
 	init_rwsem(rwsem);				\
@@ -210,10 +210,10 @@ static void init_shared_classes(void)
  * Shortcuts for lock/unlock API variants, to keep
  * the testcases compact:
  */
-#define L(x)			raw_spin_lock(&lock_##x)
-#define U(x)			raw_spin_unlock(&lock_##x)
+#define L(x)			spin_lock(&lock_##x)
+#define U(x)			spin_unlock(&lock_##x)
 #define LU(x)			L(x); U(x)
-#define SI(x)			raw_spin_lock_init(&lock_##x)
+#define SI(x)			spin_lock_init(&lock_##x)
 
 #define WL(x)			write_lock(&rwlock_##x)
 #define WU(x)			write_unlock(&rwlock_##x)
@@ -1341,7 +1341,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
 
 #define I2(x)					\
 	do {					\
-		raw_spin_lock_init(&lock_##x);	\
+		spin_lock_init(&lock_##x);	\
 		rwlock_init(&rwlock_##x);	\
 		mutex_init(&mutex_##x);		\
 		init_rwsem(&rwsem_##x);		\
@@ -2005,10 +2005,23 @@ static void ww_test_edeadlk_acquire_wrong_slow(void)
 
 static void ww_test_spin_nest_unlocked(void)
 {
-	raw_spin_lock_nest_lock(&lock_A, &o.base);
+	spin_lock_nest_lock(&lock_A, &o.base);
 	U(A);
 }
 
+/* This is not a deadlock, because we have X1 to serialize Y1 and Y2 */
+static void ww_test_spin_nest_lock(void)
+{
+	spin_lock(&lock_X1);
+	spin_lock_nest_lock(&lock_Y1, &lock_X1);
+	spin_lock(&lock_A);
+	spin_lock_nest_lock(&lock_Y2, &lock_X1);
+	spin_unlock(&lock_A);
+	spin_unlock(&lock_Y2);
+	spin_unlock(&lock_Y1);
+	spin_unlock(&lock_X1);
+}
+
 static void ww_test_unneeded_slow(void)
 {
 	WWAI(&t);
@@ -2226,6 +2239,10 @@ static void ww_tests(void)
 	dotest(ww_test_spin_nest_unlocked, FAILURE, LOCKTYPE_WW);
 	pr_cont("\n");
 
+	print_testname("spinlock nest test");
+	dotest(ww_test_spin_nest_lock, SUCCESS, LOCKTYPE_WW);
+	pr_cont("\n");
+
 	printk("  -----------------------------------------------------\n");
 	printk("                                 |block | try  |context|\n");
 	printk("  -----------------------------------------------------\n");

