Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B66D1DF184
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 23:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgEVV6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 17:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVV6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:58:22 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB01C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:58:22 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jcFgE-00Dk3E-RK; Fri, 22 May 2020 21:58:15 +0000
Date:   Fri, 22 May 2020 22:58:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] xtensa: clean up __user annotations in asm/uaccess.h
Message-ID: <20200522215814.GW23230@ZenIV.linux.org.uk>
References: <20200522214153.30163-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522214153.30163-1-jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 02:41:50PM -0700, Max Filippov wrote:
> Hello,
> 
> this series adds missing __user annotations to functions in
> asm/uaccess.h. It fixes a bunch of sparse warnings for otherwise correct
> code.
> 
> Max Filippov (3):
>   xtensa: add missing __user annotations to __{get,put}_user_check
>   xtensa: fix type conversion in __get_user_size
>   xtensa: add missing __user annotations to asm/uaccess.h

Useful test:

void __user *f(void __user * __user *p)
{
	void __user *q;
	(void)get_user(q, p);
	return q;
}


