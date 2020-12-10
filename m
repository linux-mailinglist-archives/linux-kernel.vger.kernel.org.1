Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191B92D645C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404035AbgLJSDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:03:31 -0500
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:16629 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392993AbgLJSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:03:19 -0500
Received: from [192.168.42.210] ([93.22.150.71])
        by mwinf5d35 with ME
        id 2i1a2400T1YgGEM03i1bqn; Thu, 10 Dec 2020 19:01:35 +0100
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 10 Dec 2020 19:01:35 +0100
X-ME-IP: 93.22.150.71
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_cxl=3a_Reduce_scope_for_the_variable_?=
 =?UTF-8?B?4oCcbW3igJ0gaW4gY3hsbGliX2dldF9QRV9hdHRyaWJ1dGVzKCk=?=
To:     Markus Elfring <Markus.Elfring@web.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <5cee2b25-71e0-15aa-fba6-12211b8308aa@web.de>
 <X9I1GLYCkw/q/xMu@kroah.com> <507d607a-0551-ec11-e1dc-5b9c96a361cb@web.de>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <6da89e4e-1f29-0dde-ad5b-a168f4cc1e85@wanadoo.fr>
Date:   Thu, 10 Dec 2020 19:01:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <507d607a-0551-ec11-e1dc-5b9c96a361cb@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/12/2020 à 17:04, Markus Elfring a écrit :
>>> A local variable was used only within an if branch.
>>> Thus move the definition for the variable “mm” into the corresponding
>>> code block.
>>
>> You did nothing here except add a checkpatch warning :(
> 
> elfring@Sonne:~/Projekte/Linux/next-patched> scripts/checkpatch.pl /home/elfring/Projekte/Bau/Linux/scripts/Coccinelle/tuning1/next/20201204/Flicken/0001-cxl-Reduce-scope-for-the-variable-mm-in-cxllib_get_P.patch
> total: 0 errors, 0 warnings, 16 lines checked
> 
> Regards,
> Markus
> 

Maybe:
    script/checkpatch.pl -f drivers/misc/cxl/cxllib.c

?
