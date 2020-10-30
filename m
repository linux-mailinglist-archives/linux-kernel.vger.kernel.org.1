Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A329FE3C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgJ3HJ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Oct 2020 03:09:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58408 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgJ3HJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:09:25 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kYOXL-0007jp-Jn
        for linux-kernel@vger.kernel.org; Fri, 30 Oct 2020 07:09:23 +0000
Received: by mail-pl1-f200.google.com with SMTP id h20so3883464plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xw8H3Bfn3AE6g1u4Mk5g1UKRNC8P7Hx1s9VXg3Ta4d4=;
        b=ZfQUNjXO6jCuE4AkSNdPs/qs2EwQustqa5JxQU0XA3VX6Spf0+oLHVeAZeHSt0n5jd
         PeWvybboRh8Ga2AddNjk20cpyWqsixrzb6lCHe7srLYIDhFIwSN8gv7WHiJtf5kwlNXc
         uhE6dk55KT16zF5IwKt0LgVHv+nrbixgz7eQxA3+hJGBeE80SxTYJFDy1lREVpg8FS5R
         aq3xJ/Q8dSy9XO6O+TMZEVsH0XunG13tYzkh3HgaYWjRUfx7BNaiolrTXoO7bK0IXbPr
         2y2M2w0WD+9BKHIbDHcoUoXrX4dmN2boE1kp7O3PwIdkxsBrzWhZEkXlH6uWVbL7SV2I
         v9hw==
X-Gm-Message-State: AOAM533UJC4ukMb9YGNM/XkdbgXd6RqnnqiszJhvdishWtcJOu3Rr3I/
        uI1+4ubZMRnyBohRy27flOY7r23kD85hkAhK6GLEJ+AqlUkqKpfNz+6jHPLzcwxdCdk14+y53j1
        YQrm+NW4ba387sOud/gvEexTleDK2qdmGDRwtJBnOww==
X-Received: by 2002:a63:af02:: with SMTP id w2mr992660pge.339.1604041762239;
        Fri, 30 Oct 2020 00:09:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsMwRrn6Sp8qNtcQGjp/1tNXjqyZk4sqMOpa7T/8iYOmtXLw3vJoBE2xuu0MgnLorsI8hAbw==
X-Received: by 2002:a63:af02:: with SMTP id w2mr992648pge.339.1604041762026;
        Fri, 30 Oct 2020 00:09:22 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id e11sm4894259pfl.58.2020.10.30.00.09.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 00:09:21 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] PM / reboot: Use S5 for reboot
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20201030070659.16948-1-kai.heng.feng@canonical.com>
Date:   Fri, 30 Oct 2020 15:09:17 +0800
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <45641823-1866-4FF5-9A1C-BFF61A66FCE3@canonical.com>
References: <20201030070659.16948-1-kai.heng.feng@canonical.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

> On Oct 30, 2020, at 15:06, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> After reboot, it's not possible to use hotkeys to enter BIOS setup and
> boot menu on some HP laptops.
> 
> BIOS folks identified the root cause is the missing _PTS call, and BIOS
> is expecting _PTS to do proper reset.
> 
> Using S5 for reboot is default behavior under Windows, "A full shutdown
> (S5) occurs when a system restart is requested" [1], so let's do the
> same here.

I wonder if this can also solve "HID: i2c-hid: Put ACPI enumerated devices in D3 on shutdown" fixed.

Kai-Heng

> 
> [1] https://docs.microsoft.com/en-us/windows/win32/power/system-power-states
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> kernel/reboot.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e7b78d5ae1ab..7e5aa1f78693 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -244,6 +244,8 @@ void migrate_to_reboot_cpu(void)
> void kernel_restart(char *cmd)
> {
> 	kernel_restart_prepare(cmd);
> +	if (pm_power_off_prepare)
> +		pm_power_off_prepare();
> 	migrate_to_reboot_cpu();
> 	syscore_shutdown();
> 	if (!cmd)
> -- 
> 2.17.1
> 

