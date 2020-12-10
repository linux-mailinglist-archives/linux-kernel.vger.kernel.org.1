Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BC12D64DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393070AbgLJSZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:25:16 -0500
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:28328 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392883AbgLJSXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:23:43 -0500
Received: from [192.168.42.210] ([93.22.150.71])
        by mwinf5d35 with ME
        id 2iMy2400H1YgGEM03iMzpl; Thu, 10 Dec 2020 19:21:59 +0100
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 10 Dec 2020 19:21:59 +0100
X-ME-IP: 93.22.150.71
Subject: Re: [PATCH] checkpatch: Fix "Missing a blank line after declarations"
 test on patches
To:     Joe Perches <joe@perches.com>, apw@canonical.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel.janitors,gmane.linux.kernel
References: <20201210175235.65657-1-christophe.jaillet@wanadoo.fr>
 <c0382efac23a4fb18f31974b80f25558cada7243.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <f748fbd5-f646-caa9-aec1-52ba882f9665@wanadoo.fr>
Date:   Thu, 10 Dec 2020 19:22:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <c0382efac23a4fb18f31974b80f25558cada7243.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/12/2020 à 19:13, Joe Perches a écrit :
> On Thu, 2020-12-10 at 18:52 +0100, Christophe JAILLET wrote:
>> "Missing a blank line after declarations" is not triggered on patches.
> 
> That's not true.
> It does work on any patch that does a new function addition.
> There are some patch context complications here when lines are
> added and removed such that '+' add, '-' delete, and ' ' context
> testing isn't always obvious.
> 
> So, the code was intentionally limited to just new functions.
> 
> If there are simple ways to avoid false positives, great, but I
> believe it's not trivial.
> 
>> Tweak the regex to match such cases.
> 
> Please send multiple patch examples of different forms where it
> does not work.
> 
>> This patch is mostly a PoC. I don't know enough about checkpatch.pl to be
>> sure that the fix is the right thing to do.
>> At least, it works for me :)
> 
> Always a starting point...
> 
>>
>> The [\+ ] is taken from the test just above.
>>
>> I also wonder if there is a missing ^ in the last test:
>>    (($prevline =~ /[\+ ](\s+)\S/) && $sline =~ /^[\+ ]$1\S/))
>>                    ^
>>                    |___ here
> 
> 
> 
> 

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 10 Dec 2020 14:14:07 +0100

A local variable was used only within an if branch.
Thus move the definition for the variable “mm” into the corresponding
code block.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
  drivers/misc/cxl/cxllib.c | 4 +---
  1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
index 2a1783f32254..53b919856426 100644
--- a/drivers/misc/cxl/cxllib.c
+++ b/drivers/misc/cxl/cxllib.c
@@ -170,8 +170,6 @@ int cxllib_get_PE_attributes(struct task_struct *task,
  			     unsigned long translation_mode,
  			     struct cxllib_pe_attributes *attr)
  {
-	struct mm_struct *mm = NULL;
-
  	if (translation_mode != CXL_TRANSLATED_MODE &&
  		translation_mode != CXL_REAL_MODE)
  		return -EINVAL;
@@ -182,7 +180,7 @@ int cxllib_get_PE_attributes(struct task_struct *task,
  				true);
  	attr->lpid = mfspr(SPRN_LPID);
  	if (task) {
-		mm = get_task_mm(task);
+		struct mm_struct *mm = get_task_mm(task);
  		if (mm == NULL)
  			return -EINVAL;
  		/*
--
2.29.2

