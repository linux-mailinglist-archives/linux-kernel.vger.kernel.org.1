Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6988C2AFC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgKLBgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgKKX6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:58:49 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66717C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 15:58:49 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so2809284pfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 15:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=if2NS+ErTOsYO3OeviEhjyIzgRjlx4PlS3o3mhtx7Ow=;
        b=S37Ca0R9aEdpZyzB6uJTLwCAxfpXx9Mza6g3/V/ZwSLPX8RLjn2pBkO7l7JEL/dnLC
         pUP11ysSMvyipTCX/me+MMu6IgKZNw6DeK/hocwOe54oTMksszgvwIDK+IoIewiTdpLx
         JjpOlNW+oyGV/zsky/Sk2se1J+5MPWjhcWKQHA64b4cExhLZeXgdF1UbzZizuKdGm0cO
         rjRJg5SE0Qf8sO0rB+dWYcFoZE1Vi5IXZuBI95VUt2Z9OAxUjl2s0mx9ENV+LKwCXjdX
         HuL/gcTO6yEztI757xy9GGR028QDmxw7Vc9C4hQyWgmOoLTmYVv45GPHSfHvOi5rU2M0
         9IaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=if2NS+ErTOsYO3OeviEhjyIzgRjlx4PlS3o3mhtx7Ow=;
        b=sc04gm/Ew2o6jfFR7C8Ysg2aLIJcvS1TT+6+/hVqr9JBxchiRbJdpyy7YQPT4z4UwJ
         NVSwBwo51WN6x+1XjBJmuyHC3/NNKLnPE6jvQdQLYaUxDIqrmlCJvrMtGVvgbxcTAJIB
         rX5DoZMxDOD5ElMPmK+93aMIBh/by8K+Y1k+7246iFTuvpqguPrYRmATuEamdhyBwzBy
         PgJ9F2IQ7RTg1gx62g6SQ/GiDq58EdO25HbGX03MqIAZwZPkGSsPjEob1gN8iFJFjbf+
         KQTqSHTgNy3ZG1nRy/4v8ycsXi+F8Y2CSVOX/yk4bSVHWRvmEHkz7JieRbT4aLOC5iRE
         B+Mw==
X-Gm-Message-State: AOAM533cNykan06wEwdEIpo2eGULKjes3aeAAuEMBSeh2EuvZeTB58GW
        oS0QQON9PAfQJpGthadFf5E=
X-Google-Smtp-Source: ABdhPJw1/r1XI+Qk5yhkE1Y65UZyK5WeYEtADXtwzo1FPZMRp779beUKb4k+MbtS2V7cF2pkgIL7xA==
X-Received: by 2002:a17:90a:fb90:: with SMTP id cp16mr6134133pjb.232.1605139128746;
        Wed, 11 Nov 2020 15:58:48 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id k26sm4003572pfg.8.2020.11.11.15.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:58:47 -0800 (PST)
Date:   Thu, 12 Nov 2020 08:58:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] init/console: Use ttynull as a fallback when there
 is no console
Message-ID: <X6x6tMSnS60EGNef@jagdpanzerIV.localdomain>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111135450.11214-2-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/11/11 14:54), Petr Mladek wrote:
> stdin, stdout, and stderr standard I/O stream are created for the init
> process. They are not available when there is no console registered
> for /dev/console. It might lead to a crash when the init process
> tries to use them, see the commit 48021f98130880dd742 ("printk: handle
> blank console arguments passed in.").
> 
> Normally, ttySX and ttyX consoles are used as a fallback when no consoles
> are defined via the command line, device tree, or SPCR. But there
> will be no console registered when an invalid console name is configured
> or when the configured consoles do not exist on the system.
> 
> Users even try to avoid the console intentionally, for example,
> by using console="" or console=null. It is used on production
> systems where the serial port or terminal are not visible to
> users. Pushing messages to these consoles would just unnecessary
> slowdown the system.
> 
> Make sure that stdin, stdout, stderr, and /dev/console are always
> available by a fallback to the existing ttynull driver. It has
> been implemented for exactly this purpose but it was used only
> when explicitly configured.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
