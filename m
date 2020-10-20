Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889DC29455D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 01:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439251AbgJTXLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 19:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439242AbgJTXLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 19:11:06 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B881C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 16:11:05 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a3so52243ejy.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQrdvezJYSAFOQDr78k5AJCyrl0v3hhH//5WN2kgoBM=;
        b=oo1/w0oelVxsAAQwsQ0ykiIfWkyo4Z3tcp4CWz9F9skAExBjVegSHj5Bmv8g7XOBw6
         0GSwtoEhsy+zMTYshG53kWbNXDNH7eb5AW2BzM2Dc0J1WcEVhwqsPWmZdapsh4sMR9Ma
         vZkhid0nH6RpBii5GRFd5iJFYT9oqT+cMR66xx5mcmi9G4tEmIZ57oRcHkY6saAV5u9U
         nqzUeDbPfbedjJYWfGtHgA34Ceo90TgVXDAoROFb5Sc1knr2TW5zVTJJGx5LyVf3bmAI
         DNpxd5ge5L0O1vrTMJtd76QXUU8aEf22TnnLbaPijcSqcRD4N9l9XL+oqmOf6DRbkG1I
         axdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQrdvezJYSAFOQDr78k5AJCyrl0v3hhH//5WN2kgoBM=;
        b=p5N4GvMY6fJ/p6cMu8BdwJjRPx3gXw2Q+teoYoB/rex5nMBY35PTeMkdo+vMDOeDa8
         mmo13HgfNwErA8vPLJnS2Ei8W7asjvvVZjOi5v8SZNMcXmh7ntzP+puQK2WmUnIsZVhm
         IHu65v31uXgea7H8JvLgFCqarlG4U/1ATd3Awm+r4mGI/gIroGMmqNYhzjaUdTRnBfom
         sfzhxxZ/3FzFyf9TxrdrPlZJZFgy0lbv5Jn1AWOoKMHiyztABy3RVZ7YJ7+BNvO2AH4+
         g057O0x4p6JnkM/dVAdyByhZ7lEvFu98ZLFVDzOV83eD0W7DTDk4w+y4F7WdzgAbQr+C
         Ipsw==
X-Gm-Message-State: AOAM531ATIo5iQlWjsm5L9x1UdpMCjOJ3Qgvz6HnrFHMf7MdrWz1xGdw
        6bud8V+kv/EzstV9LJvccDafMtZVRfdntMaWa0qW
X-Google-Smtp-Source: ABdhPJw0pP1X9t3t36EeA9hYaCQRGW8zWHB8n131SXlMSo9h5Uhy/9KzkMAkGla2JJpYCBV8QIKKdJzqHlqu7Kb7Iz4=
X-Received: by 2002:a17:906:ce5a:: with SMTP id se26mr521166ejb.106.1603235464181;
 Tue, 20 Oct 2020 16:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201020191732.4049987-1-salyzyn@android.com>
In-Reply-To: <20201020191732.4049987-1-salyzyn@android.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 20 Oct 2020 19:10:53 -0400
Message-ID: <CAHC9VhRMj-y2RsJ6HnbVYJV9j_snEqnmoNc6-wFacLG9wyqJpQ@mail.gmail.com>
Subject: Re: [PATCH v17 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 3:17 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> Mark Salyzyn (3):
>   Add flags option to get xattr method paired to __vfs_getxattr
>   overlayfs: handle XATTR_NOSECURITY flag for get xattr method
>   overlayfs: override_creds=off option bypass creator_cred
>
> Mark Salyzyn + John Stultz (1):
>   overlayfs: inode_owner_or_capable called during execv
>
> The first three patches address fundamental security issues that should
> be solved regardless of the override_creds=off feature.
>
> The fourth adds the feature depends on these other fixes.
>
> By default, all access to the upper, lower and work directories is the
> recorded mounter's MAC and DAC credentials.  The incoming accesses are
> checked against the caller's credentials.
>
> If the principles of least privilege are applied for sepolicy, the
> mounter's credentials might not overlap the credentials of the caller's
> when accessing the overlayfs filesystem.  For example, a file that a
> lower DAC privileged caller can execute, is MAC denied to the
> generally higher DAC privileged mounter, to prevent an attack vector.
>
> We add the option to turn off override_creds in the mount options; all
> subsequent operations after mount on the filesystem will be only the
> caller's credentials.  The module boolean parameter and mount option
> override_creds is also added as a presence check for this "feature",
> existence of /sys/module/overlay/parameters/overlay_creds
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> To: linux-fsdevel@vger.kernel.org
> To: linux-unionfs@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: kernel-team@android.com

The SELinux list should also be CC'd on these patches.  For those who
may just be seeing this, the lore link is below:

https://lore.kernel.org/linux-security-module/20201020191732.4049987-1-salyzyn@android.com/T/#t

-- 
paul moore
www.paul-moore.com
