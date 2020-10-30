Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA52A11A9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgJ3Xbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJ3Xbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:31:49 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3B8C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:31:47 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b129so4311214vsb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CL6w0chmff5m2C0b2IpuxA2r7HmIycxFzW9bCwXDFps=;
        b=CdhoZULFeqHf+kK+I3JTMy2vFsv4yB1ry6oT5kzEA32xB52i8BgU2cHZsYJM0iiJoX
         DTPUgvqCjTxKh/hhM1K1HIqy/FAz4U3FipWFO7gR+5PyvDkGaKgyrVNZ62Z7shcTGlzS
         WQm4VXiinb0d4gJZaOks0SK9h8IyW1n8sjDGW7kzPMTr4fVlIds6AlpkeD543aRxDInn
         fF665Xi6pcjQLujFKB5nY6NEReOy2Sh/jNGDlUwTs1YsmN7OV8B/LWXxxPT4Q/gZe34r
         hwQ+PTxOtqudxUQsg1rwRHurM3VrEFvJ4hcQYSCPPn3m3YtsNX79yGobFXt2ytHXOI/6
         msnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CL6w0chmff5m2C0b2IpuxA2r7HmIycxFzW9bCwXDFps=;
        b=Z0H1hh4aXoMVeDG654LkqrlvYQDdZFebwvJAuk7IlDGrqYXl8bXTYbwiYospUPl1d2
         ngaSK0cizROEfK/hIyTCYMXVl54wEmIM2KEVUy/7drKfUxTihyf0Q4tr77CiuaLk4jBG
         ICY4t5PZ5rQ9W8D1OEIWU3EwUROUAqPz1h9ZPVbKiSrv9SzAlztB61bVONKBA36xvAGU
         GlzwiJ8u2UctI+qDzGRl3s31Binkp3pP10vhBRWW77pTiRYqhvkDYUakaZ1oD0e0ON6W
         GmQ0xdh8rBJhOpPcdf1uItoSVBfLZthmlrIWT2y+kUs9PM+XG4xGTuQIUksIHvg/yQIa
         dYVw==
X-Gm-Message-State: AOAM5309Li3/fmVmgFVcGq/84O3hRhBa9wsiw3Aidv8Jr6jdQYYPP7zT
        JW1t5cBuLAgJ5wLUL3Nog+aT0HC1wmM=
X-Google-Smtp-Source: ABdhPJzP8xG/NW37suJeyKR8vELxVo3zv2h8OeetLFcEXXkrsiZ2k0iT+85kth1dmTGaoCsaSHnd2g==
X-Received: by 2002:a67:c99a:: with SMTP id y26mr9585427vsk.2.1604100706736;
        Fri, 30 Oct 2020 16:31:46 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id m14sm938999vkk.17.2020.10.30.16.31.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 16:31:46 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id m3so1803140vki.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:31:45 -0700 (PDT)
X-Received: by 2002:a1f:3f4d:: with SMTP id m74mr8629300vka.12.1604100705415;
 Fri, 30 Oct 2020 16:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <1604084530-31048-1-git-send-email-xiaochen.shen@intel.com> <1604085053-31639-1-git-send-email-xiaochen.shen@intel.com>
In-Reply-To: <1604085053-31639-1-git-send-email-xiaochen.shen@intel.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 30 Oct 2020 19:31:08 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeTu-LUBvewPiM5FFGuEiAvmp-ukdjFn4UvYwTZViCqbg@mail.gmail.com>
Message-ID: <CA+FuTSeTu-LUBvewPiM5FFGuEiAvmp-ukdjFn4UvYwTZViCqbg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/resctrl: Remove superfluous kernfs_get() calls to
 prevent refcount leak
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, HPA <hpa@zytor.com>, tony.luck@intel.com,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, pei.p.jia@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 2:45 PM Xiaochen Shen <xiaochen.shen@intel.com> wrote:
>
> Willem reported growing of kernfs_node_cache entries in slabtop when
> repeatedly creating and removing resctrl subdirectories as well as when
> repeatedly mounting and unmounting resctrl filesystem.
>
> On resource group (control as well as monitoring) creation via a mkdir
> an extra kernfs_node reference is obtained to ensure that the rdtgroup
> structure remains accessible for the rdtgroup_kn_unlock() calls where it
> is removed on deletion. The kernfs_node reference count is dropped by
> kernfs_put() in rdtgroup_kn_unlock().
>
> With the above explaining the need for one kernfs_get()/kernfs_put()
> pair in resctrl there are more places where a kernfs_node reference is
> obtained without a corresponding release. The excessive amount of
> reference count on kernfs nodes will never be dropped to 0 and the
> kernfs nodes will never be freed in the call paths of rmdir and umount.
> It leads to reference count leak and kernfs_node_cache memory leak.
>
> Remove the superfluous kernfs_get() calls and expand the existing
> comments surrounding the remaining kernfs_get()/kernfs_put() pair that
> remains in use.
>
> Superfluous kernfs_get() calls are removed from two areas:
>
>   (1) In call paths of mount and mkdir, when kernfs nodes for "info",
>   "mon_groups" and "mon_data" directories and sub-directories are
>   created, the reference count of newly created kernfs node is set to 1.
>   But after kernfs_create_dir() returns, superfluous kernfs_get() are
>   called to take an additional reference.
>
>   (2) kernfs_get() calls in rmdir call paths.
>
> Cc: stable@vger.kernel.org
> Fixes: 17eafd076291 ("x86/intel_rdt: Split resource group removal in two")
> Fixes: 4af4a88e0c92 ("x86/intel_rdt/cqm: Add mount,umount support")
> Fixes: f3cbeacaa06e ("x86/intel_rdt/cqm: Add rmdir support")
> Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
> Fixes: c7d9aac61311 ("x86/intel_rdt/cqm: Add mkdir support for RDT monitoring")
> Fixes: 5dc1d5c6bac2 ("x86/intel_rdt: Simplify info and base file lists")
> Fixes: 60cf5e101fd4 ("x86/intel_rdt: Add mkdir to resctrl file system")
> Fixes: 4e978d06dedb ("x86/intel_rdt: Add "info" files to resctrl file system")
> Reported-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Tested-by: Willem de Bruijn <willemb@google.com>

This addresses both kernfs_node_cache slab leaks I previously
observed. Thanks for fixing these!

for i in {1..100000}; do mount -t resctrl resctrl /sys/fs/resctrl;
umount /sys/fs/resctrl; done
for i in {1..100000}; do mkdir /sys/fs/resctrl/task1; rmdir
/sys/fs/resctrl/task1; done
