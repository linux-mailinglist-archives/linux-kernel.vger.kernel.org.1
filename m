Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659322C3821
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 05:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgKYEbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 23:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgKYEbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 23:31:20 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C505C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 20:31:20 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id z5so1120406ejp.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 20:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQoITc04m9qX/YolWYBe1OcinNU2l6wcKdMgtU14AFA=;
        b=1EqpT31+x7UrNi9nJv3Xmsd6iHFcCLi2sjq2U/ZgWx3jzrTUfLx6Jn4eiUswpm5BuC
         c3IG1sNO74dhw16jkI/DiDJDf8aKGvU41hCgkVL7/meob+qMKERvRKyM6wA3CntVg+nm
         GojvbrV7Xw4hKD4mASvj7lZfCLIdS0g/arU6X2YZ79X4RWhnORz7rJonDPY6abDmEwRc
         Xzt8zw0PeLrOxymq+sBsASc59J/iK3xyMAExV36L88zDbO9SImGi/g8Vh5oafp8cpM8y
         2oTIIlNSupaK5WGUdXWgmVWEY9Syi1PbhUoBJ7/Dozm+rCoMbfdEwSVpWJJ7o5GaYHi0
         l3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQoITc04m9qX/YolWYBe1OcinNU2l6wcKdMgtU14AFA=;
        b=cz7o+tWeamcuvOHF9nPpDPeSMEmLl/9eqX4mH/tMVVcNP7oAgXVtS0NLP4IrzigMhA
         UKgBk9taJfIKkKDleJdhD1hjdeZSTgVUdVNUBEIRL2ZAeUdgI2A60f64jkJe3RdXdvQb
         s/DRJBtgFdHKbTAozpkITEfaAs30TNIk3BL2cqwTTdsyaRhszvAyA4kXcpG5plsi4UlF
         VJkIGEk6I9wHDU1JXA+qyl+QGzPnh830PQE5/wTPZIIzehHOFYkYI8Gzi3uqo7LIJkQ8
         AVum9N2HTKCxbhggCbP8QRtBD//9FtqKVGZcSGkkNo5aj5Fgz5QxISwHLIreIPj80Zf1
         Es8Q==
X-Gm-Message-State: AOAM530CkCUJ/XknA2KaG0nkBGNeHEeQSepk7FJ0LJ7DaZJtxvDEZi5/
        SYcjoCbq9Ar2hUjTeTBdmssH/H+X5ZaSEgKNkNTzwBUpOooCKQM=
X-Google-Smtp-Source: ABdhPJzKIsrI5ch6e08dr6gzH4USSMha9EUcuGrCD4rq4sAvUQNRqXBe+/L+uBo1EiTAgJ1S3Ukfo4ctq6aLnnUzsX0=
X-Received: by 2002:a17:906:7c9:: with SMTP id m9mr1581773ejc.178.1606278678898;
 Tue, 24 Nov 2020 20:31:18 -0800 (PST)
MIME-Version: 1.0
References: <1604651482-9780-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201110152310.GB55411@madcap2.tricolour.ca> <CAHC9VhQiQoZh8in+zoYa5hbTN_yL-=mt7nTQFN9GAyQZ+tz-Ww@mail.gmail.com>
 <20201111030359.GB55072@madcap2.tricolour.ca> <bae6d2fa-64d9-623b-6729-3827d745ed7a@linux.alibaba.com>
 <20201111131759.GD55072@madcap2.tricolour.ca> <9784a39e-c39f-b3f9-3d05-68d63e560c75@linux.alibaba.com>
In-Reply-To: <9784a39e-c39f-b3f9-3d05-68d63e560c75@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Nov 2020 23:31:07 -0500
Message-ID: <CAHC9VhRGQOaNaPO19vKJhjaB9-wvX=bZF9X6spwOoi_C9MRb0A@mail.gmail.com>
Subject: Re: [PATCH] audit: remove unused macros
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 7:38 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
> From 5fef5f1b7b745b52bedc9c7eec9fc163202ad421 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Fri, 6 Nov 2020 16:31:22 +0800
> Subject: [PATCH v3] audit: fix macros warnings
>
> Some unused macros could cause gcc warning:
> kernel/audit.c:68:0: warning: macro "AUDIT_UNINITIALIZED" is not used
> [-Wunused-macros]
> kernel/auditsc.c:104:0: warning: macro "AUDIT_AUX_IPCPERM" is not used
> [-Wunused-macros]
> kernel/auditsc.c:82:0: warning: macro "AUDITSC_INVALID" is not used
> [-Wunused-macros]
>
> AUDIT_UNINITIALIZED and AUDITSC_INVALID are still meaningful and should
> be in incorporated.
>
> Just remove AUDIT_AUX_IPCPERM.
>
> Thanks comments from Richard Guy Briggs and Paul Moore.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Richard Guy Briggs <rgb@redhat.com>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: linux-audit@redhat.com
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/audit.c   |  2 +-
>  kernel/auditsc.c | 11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)

Sorry for the delay, this was buried in my inbox but I've just merged
it into audit/next.  Thanks for your help and patience with this!

-- 
paul moore
www.paul-moore.com
