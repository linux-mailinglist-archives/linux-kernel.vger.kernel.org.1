Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3D029E239
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgJ2CLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:11:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39660 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgJ1Vgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id 184so673379lfd.6;
        Wed, 28 Oct 2020 14:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJ/1u3561E6mMIfNICLY2s/NugY/WQD7O6Mrlmn0Hsg=;
        b=EDxqe/JRW7wHEr7E1J2zF5OK08poCt6hNmvLZ0LEvJoqmYzaZQOHCEtNYw5qRPV5VC
         yn/NBFEcRRwmsp19F+k0OuqO280SjFWFZGHHnkhKA+h69kRT2Uti45JAMoYq1Ho5sG/g
         72fg4yyCpkmqBiM05SPOVGWz8ZWKUGcHCGQeqhghPo4dgAqjtHA1H4jX9gvzCtL06t5+
         VvhjxC765mswwlye6mxlHTZAoVO17h+Gda7A0qEH0ENcr/d9OZRUeoFCCDBnR68c+vjM
         oa9XC0GuIBvJPh4ilpqfEKP0DDf5qXcwmYTKIpDBpPFqT4KnoFjHnn9wNfCVeeGkdpIB
         UQVw==
X-Gm-Message-State: AOAM5315q6PCrFPkeEp20topQoAJ0MNx6L/RBqnfT+M9HmgkEovojE5W
        TGx5pZYfBEP4EEKJLccXNTe1wLZO0sD2NRe1PQSVOOyd
X-Google-Smtp-Source: ABdhPJyXpf89lCPGYFZaY8h+h/+oPb5/uuHIuKvMA2YLEzqIyFtpe9ibvh4k+NwwFMqSBXRjCwz+PPzbuyu2OUfH7nw=
X-Received: by 2002:ac2:5329:: with SMTP id f9mr2819996lfh.525.1603900518718;
 Wed, 28 Oct 2020 08:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <1603404243-5536-1-git-send-email-eberman@codeaurora.org>
In-Reply-To: <1603404243-5536-1-git-send-email-eberman@codeaurora.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Wed, 28 Oct 2020 15:55:06 +0000
Message-ID: <CAPKp9ubYYtteYc7SDdDBPFpt3ErJpYeykQ49ey_hJbZ0yQEQSg@mail.gmail.com>
Subject: Re: [PATCH] smp: Add bootcpus parameter to boot subset of CPUs
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 7:24 AM Elliot Berman <eberman@codeaurora.org> wrote:
>
> In a heterogeneous multiprocessor system, specifying the 'maxcpus'
> parameter on kernel command line does not provide sufficient control
> over which CPUs are brought online at kernel boot time, since CPUs may
> have nonuniform performance characteristics. Thus, add bootcpus kernel
> parameter to control which CPUs should be brought online during kernel
> boot. When both maxcpus and bootcpus is set, the more restrictive of the
> two are booted.
>
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 +++++++
>  include/linux/cpu.h                             |  2 +-
>  kernel/cpu.c                                    |  4 ++--
>  kernel/smp.c                                    | 28 +++++++++++++++++++++++--
>  4 files changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65d047f..ea31af3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -449,6 +449,14 @@
>
>                         See Documentation/admin-guide/bootconfig.rst
>
> +       bootcpus=       [SMP]  List of processors that an SMP kernel
> +                       will bring up during bootup. Similar to maxcpus, except
> +                       as a cpu list as described above. The more restrictive
> +                       of maxcpus and bootcpus applies. If bootcpus=1-3 and
> +                       maxcpus=2, only processors 1 and 2 are booted. As with
> +                       maxcpus, you can bring up other plugged cpu by executing
> +                       "echo 1 > /sys/devices/system/cpu/cpuX/online"
> +

There is a fundamental assumption here that the user of this cmdline
understands how
the logical cpu numbers are allocated for the physical cpus. Based on
the discussion
I understand that you want to boot specific physical cpus for whatever
reasons and
here you want to specify the logical cpu numbers for them. So NACK for
that concept
alone irrespective of whether this concept as a whole is acceptable or not.

-- 
Regards,
Sudeep
