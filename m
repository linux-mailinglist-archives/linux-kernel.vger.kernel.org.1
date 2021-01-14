Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCB92F62EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbhANORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbhANORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:17:50 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7A0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:17:09 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id a188so3406050pfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fUbRy6sqMK/VtzYMVR0QbOcXZcr2khwVmqHoQSc9epc=;
        b=pj7TNwsLApDeIa2eRKSYiIg1yfsyUXau7xgFABNNPyApe1n7KGm8mXeEsExpdZtwwW
         9ETjKLVKXDhiyxQd+u0cv5eYujBhuaZyLsY67u0YsKwKim8MoJHagFJjdHm1yW+oSqVC
         Gm8kA/VE8Rq+S4yYFmOLHIX2yyXBv5a75Ss3RCLSOQqqwnNiLUNx/ThzD2SDFrym6Ceu
         g3prk77GeB3LNPZ2LSBeLI9yaJxIBnTJhXLf9oIaDP29gz+RYQZvtYHrCkNBMp3Jluix
         0xXlOFKOFe2xw48bH6X3PVyUPRBeYi32+Pmg3UsEBpvQCFn9dlDUGBawpaodiRyU4Wt9
         hWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fUbRy6sqMK/VtzYMVR0QbOcXZcr2khwVmqHoQSc9epc=;
        b=GKyCgaZW8fXFLmsnx64vU/7fEWVdhxEmRehKSQggWpZvKSZoSxX1crrMC6Je7T3Ur9
         bQfNqCxDjOjCdrsoocLw2R7YwVZF1qmyieIn51W34/LVkqhXfTgkNQ+ntQmnDpyERves
         cytfXV6g6ehMmCXcwya/fMs4Ij93EHulCsILlBieV8GySP8E+DpzJzZQRNd2wOMvkaxa
         be0YwPtUzf3Op1C8bBhmbWXnyYPmpky1VqI9FLFE3PZRBNnsnpAH97aA2cKwt7zHzGik
         0XIUoKhgMewpsmzVEA8HPsi2x7D3za3FqHxUZKWdM6QN3cYnsG4sbl3gU0aAM6W+MLY0
         q3tA==
X-Gm-Message-State: AOAM5337K4mIJ/WMki/ZSvQTTaWNheRorxNv8vt860o6oVISBQfOBX/l
        6RRiMHe440y8PvGeGfR5YLk5qcSBrBw=
X-Google-Smtp-Source: ABdhPJw7ILzazAe9wbtVMUvRoyAI/3n89skWbTvgB2BINSZ3dHuc/DHmTsZ8wrUmHWOEJIjv6Pn3uA==
X-Received: by 2002:a63:ce58:: with SMTP id r24mr7798553pgi.192.1610633829410;
        Thu, 14 Jan 2021 06:17:09 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f580:e184:1fc4:9744])
        by smtp.gmail.com with ESMTPSA id y5sm5952510pfp.45.2021.01.14.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 06:17:08 -0800 (PST)
Date:   Thu, 14 Jan 2021 23:17:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix kmsg_dump_get_buffer length calulations
Message-ID: <YABSYtiMBiq++Guf@google.com>
References: <20210113164413.1599-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113164413.1599-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/13 17:50), John Ogness wrote:
> 
> kmsg_dump_get_buffer() uses @syslog to determine if the syslog
> prefix should be written to the buffer. However, when calculating
> the maximum number of records that can fit into the buffer, it
> always counts the bytes from the syslog prefix.
> 
> Use @syslog when calculating the maximum number of records that can
> fit into the buffer.
> 
> Fixes: e2ae715d66bf ("kmsg - kmsg_dump() use iterator to receive log buffer content")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
