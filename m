Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE12898C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 22:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbgJIUId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 16:08:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732748AbgJIUIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 16:08:18 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602274095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8fE3/JK4Iqgidbv1by788YfY8Kzskp9ExFrndEU8c0=;
        b=byi/Syf7SgT6P6xLcmwAumDCiw9rOoC+avlfG2tkvQhMq3cXifScUULP3aQ7fx/sz4e9cI
        8/FoVZyQCRlyYwr3Y7EAMzME0yVf0Qv/HpbcEInVzLlTQiKROUuvYhrwx2TarmNHtm2lyc
        e0VwbJ+XT57A/GDEJ23Hk23/bhpRzFY1h5uxYQMLbCb07Mp9pSSHF6lgRnWxFwV+Diegg6
        Gg8yWGNpW9ZjqJdwrWXpS0/u8Na/fp2bwXshYalOZr668LbXs+zgjzSHDC2JpZfuiQROAK
        xPDtVqYt/xv9lFkhLpsuidA4WiXDDgYbZiQl8L7Mx2S+ZnT1ym2Vn1ioVMLCFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602274095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8fE3/JK4Iqgidbv1by788YfY8Kzskp9ExFrndEU8c0=;
        b=XQ3KxeD3771VVJSFpUUqONwIrvmiAn3J1ltOYju5jcXBthvPGHKOMV0oITaWsGKHrCRLoh
        UfFAzz/7dxR0BCCQ==
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Michael =?utf-8?Q?Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/4] time: make getboottime64 aware of time namespace
In-Reply-To: <20201009135554.GE15719@fieldses.org>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de> <20201008053944.32718-3-michael.weiss@aisec.fraunhofer.de> <20201009132815.5afulu5poh5ti57m@wittgenstein> <20201009135554.GE15719@fieldses.org>
Date:   Fri, 09 Oct 2020 22:08:15 +0200
Message-ID: <878scfrwls.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09 2020 at 09:55, J. Bruce Fields wrote:
> On Fri, Oct 09, 2020 at 03:28:15PM +0200, Christian Brauner wrote:
>> On Thu, Oct 08, 2020 at 07:39:42AM +0200, Michael Wei=C3=9F wrote:
>> > getboottime64() provides the time stamp of system boot. In case of
>> > time namespaces,
>
> Huh, I didn't know there were time namespaces.

There are enough people who live in their own universe, so there is a
clear need for them to have their own time zones :)

>> >  	struct timekeeper *tk =3D &tk_core.timekeeper;
>> >  	ktime_t t =3D ktime_sub(tk->offs_real, tk->offs_boot);
>> > +	/* shift boot time stamp according to the timens offset */
>> > +	t =3D timens_ktime_to_host(CLOCK_BOOTTIME, t);
>>=20
>> Note that getbootime64() is mostly used in net/sunrpc and I don't know
>> if this change has any security implications for them.
>>=20
>> Hey, Trond, Anna, Bruce, and Chuck this virtualizes boottime according
>> to the time namespace of the caller, i.e. a container can e.g. reset
>> it's boottime when started. This is already possible. The series here
>> fixes a bug where /proc/stat's btime field is not virtualized but since
>> this changes getboottime64() this would also apply to sunrpc's
>> timekeeping. Is that ok or does sunrpc rely on the hosts's boot time,
>> i.e. the time in the initial time namespace?
>
> Looking at how it's used in net/sunrpc/cache.c....  All it's doing is
> comparing times which have all been calculated relative to the time
> returned by getboottime64().  So it doesn't really matter what
> getboottime64() is, as long as it's always the same.
>
> So, I don't think this should change behavior of the sunrpc code at all.

You wish. That's clearly wrong because that code is not guaranteed to
always run in a context which belongs to the root time namespace.

AFAICT, this stuff can run in softirq context which is context stealing
and the interrupted task can belong to a different time name space.

So, no. All time namespace functions are seperate and the conversion to
and from the root name space happens at the system call boundaries.
Michael, this needs an explicit wrapper which can be used in those
places.

But that made me look at the usage of that in sunrpc.

static inline time64_t seconds_since_boot(void)
{
        struct timespec64 boot;
        getboottime64(&boot);
        return ktime_get_real_seconds() - boot.tv_sec;
}

Yikes.

static inline time64_t convert_to_wallclock(time64_t sinceboot)
{
        struct timespec64 boot;
        getboottime64(&boot);
        return boot.tv_sec + sinceboot;
}

The comment above seconds_since_boot() is just hillarious. How is the
above so much faster than ktime_get_boottime_seconds()? Arnd?

seconds_since_boot()
  getboottime64() {
     ktime_t t =3D ktime_sub(tk->offs_real, tk->offs_boot);

     *ts =3D ktime_to_timespec64(t) {
         ....
         ts.tv_sec =3D div_u64_rem(nsec, NSEC_PER_SEC, &rem);
     }
   }
   ktime_get_real_seconds()
     return tk->xtime_sec;

ktime_get_bootime_seconds() contains a division as well to convert
nanoseconds to seconds and I seriously doubt that the difference is
observable at all. So that comment was pulled out of thin air.

The real reason to have this clumsiness is that the expiry time is read
out of a buffer. That time is seconds since the epoch, aka. wall
time. There is also the conversion the other way round which is used for
procfs. All that can't be changed of course.

Up to 2010 this used get_seconds() and that was changed in commit
c5b29f885afe ("sunrpc: use seconds since boot in expiry cache"):

    This protects us from confusion when the wallclock time changes.
=20=20=20=20
    We convert to and from wallclock when  setting or reading expiry
    times.

So this stuff has been hacked up as is because there are no functions to
convert wall time to boot time and vice versa. I know it's always better
to hack something up than to talk to people.

In fact the whole thing can be simplified. You can just use time in
nanoseconds retrieved via ktime_get_coarse_boottime() which does not
read the clocksource and advances once per tick and does not contain a
divison and is definitely faster than seconds_since_boot()

The expiry time is initialized via get_expiry() which does:

   getboottime64(&boot);
   return rv - boot.tv_sec;=20

The expiry value 'rv' which is read out of the buffer is wall time in
seconds. So all you need is are function which convert real to boottime
and vice versa. That's trivial to implement and again faster than
getboottime64(). Something like this:

ktime_t ktime_real_to_boot(ktime_t real)
{
        struct timekeeper *tk =3D &tk_core.timekeeper;
        ktime_t mono =3D ktime_sub(real, tk->offs_real);
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
        return ktime_add(mono, tk->offs_boot);
}

so the above becomes:

   return ktime_real_to_boot(rv * NSEC_PER_SEC);

which is still faster than a division.

The nanoseconds value after converting back to wall clock will need a
division to get seconds since the epoch, but that's not an issue because
that backward conversion already has one today.

You'd obviously need to fixup CACHE_NEW_EXPIRY and the other place which
add's '1' to the expiry value and some janitoring of function names and
variable types, but no real big surgery AFAICT.

Thanks,

        tglx
