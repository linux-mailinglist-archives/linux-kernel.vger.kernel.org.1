Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CD72DDAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgLQVcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgLQVcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:32:10 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD9AC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:31:29 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id f16so118305uav.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z3wBihlfjGx8i9Bl44iJeyk8d+JtLB8+FBazFf3aqxI=;
        b=Xv6CKojtAib1V+eCUCifJMxvOL5xMNPU12CsNqnS6ZS3cTqa7NBT+snudMyjwBC7lY
         zIrIkm5JS6GRTI9n4MwHvRumjGT1SCi5wqO5WCJJwLyh4yfPfCIO6zimk4VB20fZpPMC
         KahIinuwAd5HF5GktyXA2aRw7m1R46DuuyzNL8ewCvqjW8ba4g8lIZU90vegIxjT2vkm
         lPkkeRfF20ApaEhpHYtH2NKg3fgmnzFYN588hVUrhHSvfiO0U4q+2oSX+WhT11jLhZAz
         EB/ZeVhRO2GcXBUgN8s1T1D/Y9J5/vXitW8lq/LnVsOV1lY9HyExZia/UphQh2G0/btb
         n9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z3wBihlfjGx8i9Bl44iJeyk8d+JtLB8+FBazFf3aqxI=;
        b=MGC+iDQ+JzWYlOoBKPliuliW7jKI8sQ3OyI8it2+oLRff0e95zIatmqkA5ht6ODjhp
         FNLzJnWWakIaPWP55nYROowT19xbyERTu5dDK/H4jtE2pnoNXnIttHaEDGH/gLymM/VA
         tmVqZ6UpQlOBu6YrfZUeJfOmahrIGJGrvkzVig2HihKEqP2rh5z+Hd5hyO5Z2OqhFm1c
         uixr75Dz+faVVFB4aFWg+3zE0B9UszKIFIFV8e4G+xpsCA9AK28BpG8FxG90OTjDKEIQ
         aMez2yzuBMMsj8SG1rButdGhELE10zsFO7Wch7nIV2NjEAOUZV+Ns8W5HXIBsOGw9WRl
         RYsA==
X-Gm-Message-State: AOAM531lDIiOSBU91ImPW+EJj2P8J8v1oYQwTte374aGBMivWenwiDdT
        nASzA6pjXjVvqPg+n1T6LrRucqeRWodQH3NJ+XU=
X-Google-Smtp-Source: ABdhPJz14o9+L0aLZo3DstAVJ8IUVDdwdJRHGNYX0c6yQJkhR9vIKQiMOnoiOLZwHPdXERCJJ74rkJYBFDeZRKqk1KI=
X-Received: by 2002:ab0:7312:: with SMTP id v18mr1113124uao.13.1608240688971;
 Thu, 17 Dec 2020 13:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20201204035318.332419-1-jim.cromie@gmail.com> <20201204035318.332419-2-jim.cromie@gmail.com>
 <X9OQkyWYBpBb+PDC@intel.com>
In-Reply-To: <X9OQkyWYBpBb+PDC@intel.com>
From:   jim.cromie@gmail.com
Date:   Thu, 17 Dec 2020 14:31:02 -0700
Message-ID: <CAJfuBxwjW107Hx46_MB5F9wR3AXxcS02fAHjF_new4sWwcGKRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] drm: RFC add choice to use dynamic debug in drm-debug
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 8:34 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Thu, Dec 03, 2020 at 08:53:17PM -0700, Jim Cromie wrote:
> > drm's debug system uses distinct categories of debug messages, mapped
> > to bits in drm.debug.  Currently, code does a lot of unlikely bit-mask
> > checks on drm.debug (in drm_debug_enabled), we can use dynamic debug
> > instead, and get all that jump_label goodness.

> Is there an actual need to go through dyndbg and do all this stringy
> stuff, or would just eg. a static keys array for the debug categories
> get us the benefits of jump_label?
>

You certainly can strip the car, take the engine.
but you might need some of the drivetrain too.
maybe you want to skip the heated seats ?
dyndbg has some stuff you dont need, for sure.

for one, its heavy on data per callsite, with a static-key and
overhead for each.

But Id be wary that the jump-label code-patching is a slow path,
so trying to change hundreds of jump-sites with one static-key field
may run into problems with long lock hold times, etc.

There is a batching mechanism built-in to the jump-label stuff somewhere,
my impression is that it amortized system-wide syncs while being RT aware.


I've been working on trimming dyndbg down, at least the memory.
I'll be sending it out shortly, but heres a preview:


Subject: [RFC PATCH v2 0/7] dynamic debug diet plan

V2 is a rethought diet plan for dyndbg (I meant -v1 as rfc).

at highest level, patchset does:
1- move struct _ddebug "selector" fields to new struct _ddebug_callsite
2- make ddebug_callsites optional, good for some users
3- allow dropping callsites by those users.

1-v2. Rasmus noted that I shouldn't move format with the other fields,
and I realized that the "module:function:line" dynamic prefixes are
ultimately just log decorations, and are not needed for certain use
cases, including drm (with category -> prefix adaptation).

The drm use case:

- can benefit from jump-labels to avoid drm_debug_enabled()
- can map categories to format-prefixes: "drm:core:" "drm:kms:" etc
- can use dynamic_debug_exec_queries("format ^drm:core: +p", NULL)
- drm + amdgpu have ~3200 drm-debugs, drm + i915 have ~1600

If drm dropped optional site info, net 16 bytes saved / callsite, maybe mor=
e...

dropping optional info : module file func means loss of log "decorations"
and slimmer contents of control file.  uncategorized pr-debugs can be
avoided when dropping callsites.   Even with dropped info,
format, line, module queries can select individual sites precisely.

As of now, we still need the __dyndbg_callsites linker section; the
3-drop is just a forget-the-addy, not a kfree.

But compression is possible. v1 tried using zram, with mixed success.
v2 is a better foundation to re-try the zram.
