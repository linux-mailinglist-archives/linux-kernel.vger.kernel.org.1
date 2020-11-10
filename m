Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5A12AD987
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgKJO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:58:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:41288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730432AbgKJO6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:58:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605020314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SM0mRE+PVzXgiw6lwVn9+EZO1FGebDrpEtiYSYE8FIk=;
        b=UgkiC+zz3BDZNiwUsZwwaFxjbgYanrJ0hoQ9FQdkvscnQavKy7fI00hJhl4vXBAvkCssvF
        Z8nZ6+XHpqW1tsrx3GMtdX0jekdcsqb0LOXAEE1sPg2vrUa+lrQtC9/FbM/sPh/BCzNhHa
        WlUmNnfLJ+m6Uoc+5IIKsr4ewY6KXMA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE7B3AF3B;
        Tue, 10 Nov 2020 14:58:34 +0000 (UTC)
Date:   Tue, 10 Nov 2020 15:58:34 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v3] reboot: allow to specify reboot mode via sysfs
Message-ID: <20201110145834.GE20201@alley>
References: <20201109164538.18934-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109164538.18934-1-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-11-09 17:45:38, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> The kernel cmdline reboot= option offers some sort of control
> on how the reboot is issued.
> Add handles in sysfs to allow setting these reboot options, so they
> can be changed when the system is booted, other than at boot time.
> 
> The handlers are under <sysfs>/kernel/reboot, can be read to
> get the current configuration and written to alter it.
> 
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-reboot
> @@ -0,0 +1,31 @@
> +What:		/sys/kernel/reboot
> +Date:		November 2020
> +KernelVersion:	5.11
> +Contact:	Matteo Croce <mcroce@microsoft.com>
> +Description:	Interface to set the kernel reboot mode, similarly to
> +		what can be done via the reboot= cmdline option.
> +		(see Documentation/admin-guide/kernel-parameters.txt)
> +

s/reboot mode/reboot behavior/

The reboot mode is only one of the modified parameters.


> +What:		/sys/kernel/reboot/mode
> +Date:		November 2020
> +KernelVersion:	5.11
> +Contact:	Matteo Croce <mcroce@microsoft.com>
> +Description:	Reboot mode. Valid values are: cold warm hard soft gpio
> +
> +What:		/sys/kernel/reboot/type
> +Date:		November 2020
> +KernelVersion:	5.11
> +Contact:	Matteo Croce <mcroce@microsoft.com>
> +Description:	Reboot type. Valid values are: bios acpi kbd triple efi pci
> +
> +What:		/sys/kernel/reboot/cpu
> +Date:		November 2020
> +KernelVersion:	5.11
> +Contact:	Matteo Croce <mcroce@microsoft.com>
> +Description:	CPU number to use to reboot.
> +
> +What:		/sys/kernel/reboot/force
> +Date:		November 2020
> +KernelVersion:	5.11
> +Contact:	Matteo Croce <mcroce@microsoft.com>
> +Description:	Force an immediate reboot.

This makes me feel like that the kernel will reboot
immediately when you write "1". It would deserve a better
explanation that would make it clear, something like:

Description:	Use forced reboot that does not contact the init system.


Otherwise, it looks good to me. With the two above updates:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
