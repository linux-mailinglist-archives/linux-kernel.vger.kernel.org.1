Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6192D5E99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391822AbgLJOvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:51:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389365AbgLJOrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:47:19 -0500
Date:   Thu, 10 Dec 2020 15:47:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607611598;
        bh=8roGAcaqdWV7Cx09/qYtV5EtfHdEnYqtywgHdVmgwQk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzuzGeJwxxrfyurgYKXmQEv0RmrKj0q3aVAr8MampgupErIRCWrDwttbbsyj8Irne
         3NM4NP5OQ3eYqUzIj21UyFrikfMa9m70g19KwKQQ1rMk4RXUZlXScLznpcDZNiMOdA
         PnzoAkjWVN0o1SUe5Zxd/6FVF56Hs6xskQfgt6lU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxl: Reduce scope =?utf-8?Q?fo?=
 =?utf-8?B?ciB0aGUgdmFyaWFibGUg4oCcbW3igJ0=?= in cxllib_get_PE_attributes()
Message-ID: <X9I1GLYCkw/q/xMu@kroah.com>
References: <5cee2b25-71e0-15aa-fba6-12211b8308aa@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cee2b25-71e0-15aa-fba6-12211b8308aa@web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 03:35:38PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 10 Dec 2020 14:14:07 +0100
> 
> A local variable was used only within an if branch.
> Thus move the definition for the variable “mm” into the corresponding
> code block.

You did nothing here except add a checkpatch warning :(

dropped.

greg k-h
