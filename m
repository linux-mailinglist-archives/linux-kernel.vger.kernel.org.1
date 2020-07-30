Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639F023373F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 18:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgG3Q7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 12:59:51 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:29680 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3Q7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:59:50 -0400
Date:   Thu, 30 Jul 2020 16:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1596128388; bh=62mXeB+bzPp/3KY1oadPg0iQ1m2zwDBYw2KcUlbIHBA=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=AdCaYjEVmdus2knhEph/SsmYSEgilZu5/N3WUfSW+aKCRsWxYBvC89TvRJ9SPrbHE
         0tuHZryQwdGGZgiZiEk6Vu/I20UtJPnn69pDoP7rXHnRoNeltJI0FeFe0C+qO4DZAi
         +Mq5rlgJNBS2QIZpWxDdaBtcpgGcfTAP3ai/+d0SkUqhOiHfsqyrK4zxLv7rHByxbc
         CJJ170Iax5WnkTUJMVFGqQnciI84E14xHIQyuIQpYWcawR3+mpVXGe9AIzSO1aGFIr
         RVcBK9YgoxECOTlNxOhjsA257U6BcIU+VpNeNxdJbCaMSvJlyzG0iURGs6l4Ure96W
         bD76gW+5+kWqg==
To:     Jonathan Corbet <corbet@lwn.net>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexander Lobakin <alobakin@pm.me>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH] mailmap: add entry for <alobakin@marvell.com>
Message-ID: <9xzFiqHAFGYuKfUycRaCQSIgsqmeL9E9SA3lSoqOMUPhFVaAgSgvukCUWO7iRbjtiUrFjK46fhu7dJ5TaCv1EjaNFm5yF_H3y5S1s_QALCA=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,TVD_PH_BODY_ACCOUNTS_PRE
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Marvell account has been suspended, map the address to my private mail.

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e662fdac632b..a96f1b38fa58 100644
--- a/.mailmap
+++ b/.mailmap
@@ -19,6 +19,7 @@ Aleksandar Markovic <aleksandar.markovic@mips.com> <aleks=
andar.markovic@imgtec.c
 Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@intel.com>
 Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@linaro.org>
 Alexander Lobakin <alobakin@pm.me> <alobakin@dlink.ru>
+Alexander Lobakin <alobakin@pm.me> <alobakin@marvell.com>
 Alexander Lobakin <alobakin@pm.me> <bloodyreaper@yandex.ru>
 Alexandre Belloni <alexandre.belloni@bootlin.com> <alexandre.belloni@free-=
electrons.com>
 Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
--=20
2.28.0


