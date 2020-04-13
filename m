Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18E31A6446
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 10:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgDMIon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 04:44:43 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:50577 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727770AbgDMIon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:44:43 -0400
Received: from [192.168.1.6] (x4d0d8c93.dyn.telefonica.de [77.13.140.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5A977206442C1;
        Mon, 13 Apr 2020 10:44:40 +0200 (CEST)
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     regressions@leemhuis.info
Subject: [regression 5.7-rc1] System does not power off, just halts
Message-ID: <f4eaf0ca-6cd6-c224-9205-bf64ca533ff5@molgen.mpg.de>
Date:   Mon, 13 Apr 2020 10:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


A regression between causes a system with the AMD board MSI B350M MORTAR 
(MS-7A37) with an AMD Ryzen 3 2200G not to power off any more but just 
to halt.

The regression is introduced in 9ebe5422ad6c..b032227c6293. I am in the 
process to bisect this, but maybe somebody already has an idea.


Kind regards,

Paul
