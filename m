Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2198D22BA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 01:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgGWXNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 19:13:19 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:21570 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgGWXNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:13:18 -0400
Date:   Thu, 23 Jul 2020 22:57:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595545039;
        bh=IABwxqdCkkyTX2FsPRq3CfvvI2V2JvrQN6xMWEn3Gqk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=hkTpBGEzkydV88rPZf+GE+1a6u71lj+Hn7+btGAvmLwhOV6+0b8CixNJ++hZjksJq
         hbwiTSivH0iQsHR5omtQb3yTBLGsK6OYiic6AfLKoOHoWgDol7ANoc9BT7F1+8l+XY
         xSeVgzqqs0bbVzLjIEK7keh4RyfYW6/+OmULxXTc=
To:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
From:   Mazin Rezk <mnrzk@protonmail.com>
Cc:     Mazin Rezk <mnrzk@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "1i5t5.duncan@cox.net" <1i5t5.duncan@cox.net>,
        "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
Message-ID: <3iDgskt5iP3y77MHUJ2_5uSThyUteHxPvVqoL5SpnpTIpz5cdkifyDOynpiVukS_peaYGOkn9bHSpvRYa-vFOCjUYH68taIuKyZqhOByAVI=@protonmail.com>
In-Reply-To: <ccd5d51b-b018-a3db-169b-ba6278a7be9f@amd.com>
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com> <ccd5d51b-b018-a3db-169b-ba6278a7be9f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_REPLYTO
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that I spoke too soon. I ran the system for another hour after
submitting the patch and the bug just occurred. :/

Sadly, that means the bug isn't really fixed and that I have to go
investigate further.

At the very least, this patch seems to delay the occurrence of the bug
significantly which may help in further discovering the cause.

On Thursday, July 23, 2020 6:16 PM, Kazlauskas, Nicholas <nicholas.kazlausk=
as@amd.com> wrote:

> On 2020-07-23 5:10 p.m., Mazin Rezk wrote:
>
> > When amdgpu_dm_atomic_commit_tail is running in the workqueue,
> > drm_atomic_state_put will get called while amdgpu_dm_atomic_commit_tail=
 is
> > running, causing a race condition where state (and then dm_state) is
> > sometimes freed while amdgpu_dm_atomic_commit_tail is running. This bug=
 has
> > occurred since 5.7-rc1 and is well documented among polaris11 users [1]=
.
> > Prior to 5.7, this was not a noticeable issue since the freelist pointe=
r
> > was stored at the beginning of dm_state (base), which was unused. After
> > changing the freelist pointer to be stored in the middle of the struct,=
 the
> > freelist pointer overwrote the context, causing dc_state to become garb=
age
> > data and made the call to dm_enable_per_frame_crtc_master_sync derefere=
nce
> > a freelist pointer.
> > This patch fixes the aforementioned issue by calling drm_atomic_state_g=
et
> > in amdgpu_dm_atomic_commit before drm_atomic_helper_commit is called an=
d
> > drm_atomic_state_put after amdgpu_dm_atomic_commit_tail is complete.
> > According to my testing on 5.8.0-rc6, this should fix bug 207383 on
> > Bugzilla [1].
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D207383
> > Fixes: 3202fa62f ("slub: relocate freelist pointer to middle of object"=
)
> > Reported-by: Duncan 1i5t5.duncan@cox.net
> > Signed-off-by: Mazin Rezk mnrzk@protonmail.com
>
> Thanks for the investigation and your patch. I appreciate the help in
> trying to narrow down the root cause as this issue has been difficult to
> reproduce on my setups.
>
> Though I'm not sure this really resolves the issue - we make use of the
> drm_atomic_helper_commit helper function from DRM which internally does
> what you're doing with this patch:
>
> drm_atomic_state_get(state);
> if (nonblock)
> queue_work(system_unbound_wq, &state->commit_work);
>
>     else
>     =09commit_tail(state);
>
>
> So even when it gets queued off to the unbound workqueue we still have a
> reference on the state.
>
> That reference gets dropped as part of commit tail helper in DRM as well:
>
> if (funcs && funcs->atomic_commit_tail)
>
>     =09funcs->atomic_commit_tail(old_state);
>
>     else
>     =09drm_atomic_helper_commit_tail(old_state);
>
>
> commit_time_ms =3D ktime_ms_delta(ktime_get(), start);
> if (commit_time_ms > 0)
>
>     =09drm_self_refresh_helper_update_avg_times(old_state,
>     =09=09=09=09=09 (unsigned long)commit_time_ms,
>     =09=09=09=09=09 new_self_refresh_mask);
>
>
> drm_atomic_helper_commit_cleanup_done(old_state);
>
> drm_atomic_state_put(old_state);
>

I initially noticed that right after I wrote this patch so I was expecting
the patch to fail. However, after several hours of testing, the crash just
didn't occur so I believed the bug was fixed.

> So instead of a use after free happening when we access the state we get
> a double-free happening later at the end of commit tail in DRM.
>
> What I think would be the right next step here is to actually determine
> what sequence of IOCTLs and atomic commits are happening under your
> setup with a very verbose dmesg log. You can set a debug level for DRM
> in your kernel parameters with something like:
>
> drm.debug=3D0x54
>
> I don't see anything in amdgpu_dm.c that looks like it would be freeing
> the state so I suspect something in the core is this doing this.

Going through the KASAN use-after-free bug report in the Bugzilla
attachments, it appears that the state is being freed at the end of
commit_tail. Perhaps amdgpu_dm_atomic_commit_tail is being called on the
the same old state twice? I can't quite think of any other possible
explanation as to why that happens.

>
> > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
> > 1 file changed, 3 insertions(+)
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 86ffa0c2880f..86d6652872f2 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -7303,6 +7303,7 @@ static int amdgpu_dm_atomic_commit(struct drm_dev=
ice *dev,
> > * unset legacy_cursor_update
> > */
> >
> > -   drm_atomic_state_get(state);
>
> Also note that if the drm_atomic_helper_commit() call fails here then
> we're going to never free this structure. So we should really be
> checking the return code here below before trying to do this, if at all.

Oh right, that's true. I looked at amdgpu_dm_atomic_commit_tail and didn't
see any return statements in there, so I thought it was safe.

>
> Regards,
> Nicholas Kazlauskas
>
> >       return drm_atomic_helper_commit(dev, state, nonblock);
> >
> >       /*TODO Handle EINTR, reenable IRQ*/
> >
> >
> > @@ -7628,6 +7629,8 @@ static void amdgpu_dm_atomic_commit_tail(struct d=
rm_atomic_state *state)
> >
> >       if (dc_state_temp)
> >       =09dc_release_state(dc_state_temp);
> >
> >
> > -
> > -   drm_atomic_state_put(state);
> >     }
> >
> >
> > --
> > 2.27.0

Thanks,
Mazin Rezk
