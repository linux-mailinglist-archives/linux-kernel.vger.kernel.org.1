Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E55278F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgIYQyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:54:17 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:49572 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgIYQyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=28cqnasr75E8p2FpIR3JEwCn5rkK20DQw7UOa0lKlec=; b=kIWREGw57vyQX8Tx0wQRFgmCa9
        hfl+tPhr/lyWTf1aW8IZkDCBlDpW9kUqT6Wxc3lVa2ILxHGXBNpTACZvbFFMLsJnt/xFDt7x1CBLB
        gzu3PY757TDV9dYb6PKnMSaxCCoBLymbGjsD0b1QamoGeLc3TKX7AVNFWajCnfiDwkek=;
Received: from pool-72-73-20-93.clppva.fios.verizon.net ([72.73.20.93] helo=derek-personal-arch.fios-router.home)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <dlesho@codeweavers.com>)
        id 1kLqz6-00020E-7b; Fri, 25 Sep 2020 11:54:15 -0500
From:   Derek Lesho <dlesho@codeweavers.com>
To:     linux-kernel@vger.kernel.org
Cc:     Derek Lesho <dlesho@codeweavers.com>
Subject: Re: [RFC] mm: Allow 64-bit mmap syscalls to access higher addresses.
Date:   Fri, 25 Sep 2020 11:53:44 -0500
Message-Id: <20200925165343.292885-1-dlesho@codeweavers.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925153703.288236-1-dlesho@codeweavers.com>
References: <20200925153703.288236-1-dlesho@codeweavers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -36.6
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  For some reason, git send-email cut off the first paragprah
    in my first email, so I'm resending it now: Hello everyone, I am sending
   this mostly as a discussion starter/curiosity. I would like to be able to
   use the 48-bit address range while in long mode on an IA32 process. However,
    these two checks pre [...] 
 Content analysis details:   (-36.6 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 USER_IN_WELCOMELIST    user is listed in 'welcomelist_from'
  -20 USER_IN_WHITELIST      DEPRECATED: See USER_IN_WELCOMELIST
  -20 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -0.5 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  3.9 AWL                    AWL: Adjusted score from AWL reputation of From: address
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, git send-email cut off the first paragprah in my first email, so I'm resending it now:

Hello everyone, I am sending this mostly as a discussion starter/curiosity.  I would like to be able to use the 48-bit address range while in long mode on an IA32 process.  However,
these two checks prevent mmap and munmap from dealing with addresses in that range.  My question, is there any will to support something like this in the kernel, and if so, how
would it be accomplished, generally.  Maybe the TASK_SIZE macro could check for whether we are currently in the context of a x86-64 syscall?

For those curious about my usecase, I'm working on running some windows 64-bit driver code in context of any given process.  I accomplish this by mapping some of the fake kernel
bits in the target process, and running the code in a dedicated thread.
---
