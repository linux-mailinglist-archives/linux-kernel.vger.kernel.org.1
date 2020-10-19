Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95F329281E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgJSN1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:27:33 -0400
Received: from mail.efficios.com ([167.114.26.124]:39214 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgJSN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:27:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 920DC255067;
        Mon, 19 Oct 2020 09:27:32 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OKcVfHdU06_6; Mon, 19 Oct 2020 09:27:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 58E70255482;
        Mon, 19 Oct 2020 09:27:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 58E70255482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603114052;
        bh=bmNV45YBApcUaejX/sOoSoY9E3QAjn7c8WF2xY0RGX8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=JGzAGoR6/zgOYTW7umULfGPJPJiM9GnG4oAFY/kYjrGBMphI4EWlk2hSGnPQ0ujur
         wfvIvJo+dvKwQbPksVk/9BshI62ObUceIy5VQIxYBeLL5pjDlnx3FoTjNQup9rShTi
         JNBVpnFMhBU6bW6J3Vh8ElDOhnNfoqxQTR8jKymw7KSgUG3/Qa6NVUg56exPDxC2M2
         g6mvEt44qX3ZXfE1K2c8aSaKLZnI9YDIcYpLD3ua4Yxw4mp3/K6gbSztlTPG909kId
         vc3JdnEYm1GPIiA8dcJnTjRhfK1ztAeX1Sr9jQqRh9E1qC9JL2RkVyqtZiwSCW9Y2U
         +M32lXc0Xbm4Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RgxRZ73nwax1; Mon, 19 Oct 2020 09:27:32 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4C5AB25523E;
        Mon, 19 Oct 2020 09:27:32 -0400 (EDT)
Date:   Mon, 19 Oct 2020 09:27:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Rong Chen <rong.a.chen@intel.com>,
        Anton Blanchard <anton@au.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>, 0day robot <lkp@intel.com>
Message-ID: <104775100.27222.1603114052224.JavaMail.zimbra@efficios.com>
Subject: Unreliable will-it-scale context_switch1 test on 0day bot
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Index: ksY51HzN7+LfIgm53yYh1p91s0pyBw==
Thread-Topic: Unreliable will-it-scale context_switch1 test on 0day bot
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I pointed out an issue with the will-it-scale context_switch1 test run by the 0day bot on
October 7, 2020, and got no reply.

Until this issue is solved, the results of those tests are basically pure noise when run on
SMT hardware:

https://lore.kernel.org/lkml/1183082664.11002.1602082242482.JavaMail.zimbra@efficios.com/

Who is maintaining those tests and the 0day bot ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
