Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1563A296091
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900551AbgJVN7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:59:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65392 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900532AbgJVN7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:59:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CH8B33krkz9vBJc;
        Thu, 22 Oct 2020 15:59:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id cMVhWiMuAegN; Thu, 22 Oct 2020 15:59:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CH8B32wBVz9vBJZ;
        Thu, 22 Oct 2020 15:59:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C8E1F8B805;
        Thu, 22 Oct 2020 15:59:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8Fb2X8RVxBJY; Thu, 22 Oct 2020 15:59:40 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 769218B816;
        Thu, 22 Oct 2020 15:59:40 +0200 (CEST)
To:     Joe Perches <joe@perches.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Problem with checkpatch.pl (commit f5f613259f3f ("checkpatch: allow
 not using -f with files that are in git"))
Message-ID: <82054b17-292d-3b3d-e95c-9abe7fa0c444@csgroup.eu>
Date:   Thu, 22 Oct 2020 15:59:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Runnning ./scripts/checkpatch.pl -g HEAD, I get the following error:

Global symbol "$gitroot" requires explicit package name at ./scripts/checkpatch.pl line 980.
Execution of ./scripts/checkpatch.pl aborted due to compilation errors.

Reverting commit f5f613259f3f ("checkpatch: allow not using -f with files that are in git") clears 
the problem.

Christophe
