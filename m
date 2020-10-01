Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2527F9A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgJAGvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:51:03 -0400
Received: from z5.mailgun.us ([104.130.96.5]:45927 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgJAGvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:51:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601535062; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=gwugQkJdwAsUp0rRePmNc1xDsnuBaLbzJBqGrDfhTLY=; b=Sy6qEBlS552Mxfqo/yIrJkVg/EWIm89FKz4yvorVALN8j0FLgXPxyOFko0gH3OZo/nKRdwag
 0sP+JVY7EuU28vuL0s/iAy5LLl0x65QXzBG8UcQhkt+12f50iSVFFpkbb+W3xIlxYvI6I5/2
 8cIYRCqsvqq8szOLUQnv3R+TmCQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f757c5680da0872b754359f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 06:51:02
 GMT
Sender: asitshah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7A2EC433CA; Thu,  1 Oct 2020 06:51:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: asitshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D5E0C433C8;
        Thu,  1 Oct 2020 06:51:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Oct 2020 12:21:01 +0530
From:   asitshah@codeaurora.org
To:     linux-firmware@kernel.org, jwboyer@kernel.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantg@codeaurora.org, gubbaven@codeaurora.org,
        abhishekpandit@chromium.org, bgodavar@codeaurora.org
Subject: Update WCN3991 FW with new enhancement
Message-ID: <d4a4a37625f6b562c5096cbe1a6ccb61@codeaurora.org>
X-Sender: asitshah@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Team,

Please include updated firmware bins for WCN3991.

Snapshot of pull request is as below, let me know if anything is 
missing.


>>>>>>>>>>>>>> 

The following changes since commit 
b78a66c909c7150601e1b2a810b0e7c8f98d920c:

   linux-firmware: Update firmware for Cadence MHDP8546 DP bridge 
(2020-09-28 11:38:27 -0400)

are available in the git repository at:

   https://github.com/shahasit/linux-firmware-bt/tree/master

for you to fetch changes up to ad1da95d52f1a9206da3ef52f3484f3b89ec6615:

   QCA : Updated firmware files for WCN3991 (2020-10-01 12:03:01 +0530)

----------------------------------------------------------------
Asit Shah (1):
       QCA : Updated firmware files for WCN3991

  WHENCE           |   1 +
  qca/crbtfw32.tlv | Bin 125896 -> 126300 bytes
  qca/crnv32.bin   | Bin 5299 -> 5407 bytes
  qca/crnv32u.bin  | Bin 0 -> 5407 bytes
  4 files changed, 1 insertion(+)
  create mode 100644 qca/crnv32u.bin


Regards,
Asit
