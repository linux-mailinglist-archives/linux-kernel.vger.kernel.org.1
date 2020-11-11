Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA9A2AFC6E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgKLBgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgKKX7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:59:23 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D5C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 15:59:21 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f38so2608850pgm.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 15:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tsmfCCdrbb/ZwZwSPwH4J4qd2xy4d6TEFRqpFFfpq9c=;
        b=geTCy/5ITpdMoGYEJmczBceJppWgeubVn5xOGwIDmtN8SlmwgKCqB3PTAaK6VLxmc+
         ZLONDAbcifEOKoezQPQhbZUlQ6gIAZbgG51ANfRAQZkKiSJLYSFBRZgLVvDwE2lW4JG/
         PtTzihFmonMJjNqmT75o25IKPISNvW+7YiIMGAlb+sxRcJm4wFjR9gXKajYVqKHTZhHO
         2VAJhVECVQRaZ5Kx8pzBredrCjkTz1+4UfnM8kTOWpV/AXoRuwKy6kANKfpxxJAP+Rav
         lDmmnMMPVh3b02vhvPZ7C3ws500Kbrv8O2qtGhp2eanuTWH8PB1k8s3g+MRuzt316ERN
         FU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tsmfCCdrbb/ZwZwSPwH4J4qd2xy4d6TEFRqpFFfpq9c=;
        b=egBOWYnETdan5BWU1pY7RBuiROERHOYXPDv+L4hSk6iprQNPk/7lx94v+3AnvZPxkV
         9fHMIVpOQEXaHu2E5kM8btRZJBoBqIIgRk1uvyaXBA3dZjCGuUj1r/4/hEV7OQXM8bhN
         tmXtdFjVccfw9WdlUzjHN0PU8Y1wcQQmnNea6GxcqtHPf69dLeta7l/XTzTdfr7PLZpZ
         wJiSDu0nJ7QhGPtz0dfsJoBHXfzOQSIOK11ANULUxCuKx9NE0FnUbC2X2PgjQTnNUikl
         +ryAH8N4H5pyAInKN0jRZelelMkQZiJahrlHBzs+nc3RVn90ZQ6ZB87Qqh7Kb88Vjfjh
         QSEA==
X-Gm-Message-State: AOAM532tgI25y4WmSsb/ScnW4dW7cvkcbBu/j39K77UGBUHpdfb+B8qc
        COWHARjZpvJXJkhVnBgFe68=
X-Google-Smtp-Source: ABdhPJyThberwyLK0MBCHy4nDKzI34WJDTKxIMmxMQRgKRXs+t4v0XJ/A9ed6FRXDaefwkt4EzxHNw==
X-Received: by 2002:a63:1357:: with SMTP id 23mr23511560pgt.13.1605139161110;
        Wed, 11 Nov 2020 15:59:21 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id n72sm4187988pfd.202.2020.11.11.15.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:59:20 -0800 (PST)
Date:   Thu, 12 Nov 2020 08:59:18 +0900
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
Subject: Re: [PATCH 2/2] printk/console: Allow to disable console output by
 using console="" or console=null
Message-ID: <X6x61h58ZvRgyTQR@jagdpanzerIV.localdomain>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111135450.11214-3-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/11/11 14:54), Petr Mladek wrote:
> The commit 48021f98130880dd74 ("printk: handle blank console arguments
> passed in.") prevented crash caused by empty console= parameter value.
> 
> Unfortunately, this value is widely used on Chromebooks to disable
> the console output. The above commit caused performance regression
> because the messages were pushed on slow console even though nobody
> was watching it.
> 
> Use ttynull driver explicitly for console="" and console=null
> parameters. It has been created for exactly this purpose.
> 
> It causes that preferred_console is set. As a result, ttySX and ttyX
> are not used as a fallback. And only ttynull console gets registered by
> default.
> 
> It still allows to register other consoles either by additional console=
> parameters or SPCR. It prevents regression because it worked this way even
> before. Also it is a sane semantic. Preventing output on all consoles
> should be done another way, for example, by introducing mute_console
> parameter.
> 
> Link: https://lore.kernel.org/r/20201006025935.GA597@jagdpanzerIV.localdomain
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
