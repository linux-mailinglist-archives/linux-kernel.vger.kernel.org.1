Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856502BA1AB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 06:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgKTFIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 00:08:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgKTFIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 00:08:20 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D288223AC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605848899;
        bh=EMPOwX+GM6nne2Kxd6eTK1Le8OOHUrcl7eJBCN+OBc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P005jFr+rlVpGC65OoFhYcVpvQb1/lm0eauhhQ1gOh7avXZy4cy1MtYdM3Mp1nzFS
         d74xYGvlEOsBpW9ppN680m2IC2boGMvV3ONktSHDyrjFwL9wwE3A6fSf15MS8YuX6n
         JnAAAE9tjC5vv0TbQ38d9Sg1VO5dvTLU7xU5gGHk=
Received: by mail-wr1-f48.google.com with SMTP id 23so8698599wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 21:08:19 -0800 (PST)
X-Gm-Message-State: AOAM530so0qyPQnczfxR/xtzwf1dYcITVE91QsT60+8Nl2Z6AOHSj720
        3n7YgqgR2LdYPvIoxC1nSMYQdYjvy4Wptxxhtxb7QA==
X-Google-Smtp-Source: ABdhPJxMOOJqKZta/OshTg1/fg58mrs+DA0NdFP6zdDDCPA/e3CZ92xZ6ykh6G6GqDoixK1E9rQobYZSYNKCht6bqKU=
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr13572183wro.184.1605848897708;
 Thu, 19 Nov 2020 21:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20201119233257.2939-1-chang.seok.bae@intel.com> <20201119233257.2939-15-chang.seok.bae@intel.com>
In-Reply-To: <20201119233257.2939-15-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 19 Nov 2020 21:08:03 -0800
X-Gmail-Original-Message-ID: <CALCETrWhw_PfdhTY6zzewwwwB35x5LFDouZJ8+C_pcePNc69-w@mail.gmail.com>
Message-ID: <CALCETrWhw_PfdhTY6zzewwwwB35x5LFDouZJ8+C_pcePNc69-w@mail.gmail.com>
Subject: Re: [PATCH v2 14/22] x86/fpu/xstate: Inherit dynamic user state when
 used in the parent
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 3:37 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> When a new task is created, the kernel copies all the states from the
> parent. If the parent already has any dynamic user state in use, the new
> task has to expand the XSAVE buffer to save them. Also, disable the
> associated first-use fault.

This seems like a mistake.  If init uses AMX for some misguided
reason, ever task on the whole system will end up with AMX state
allocated.
