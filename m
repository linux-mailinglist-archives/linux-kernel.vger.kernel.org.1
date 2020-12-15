Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D777C2DB49B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgLOTkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:40:46 -0500
Received: from atlmailgw2.ami.com ([63.147.10.42]:43558 "EHLO
        atlmailgw2.ami.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgLOTkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:40:12 -0500
X-Greylist: delayed 949 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Dec 2020 14:40:09 EST
X-AuditID: ac10606f-247ff70000001934-30-5fd90d39f54f
Received: from atlms1.us.megatrends.com (atlms1.us.megatrends.com [172.16.96.144])
        (using TLS with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by atlmailgw2.ami.com (Symantec Messaging Gateway) with SMTP id F2.58.06452.A3D09DF5; Tue, 15 Dec 2020 14:23:38 -0500 (EST)
Received: from ami-us-wk.us.megatrends.com (172.16.98.207) by
 atlms1.us.megatrends.com (172.16.96.144) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Tue, 15 Dec 2020 14:23:36 -0500
From:   Hongwei Zhang <hongweiz@ami.com>
To:     <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, Jakub Kicinski <kuba@kernel.org>,
        David S Miller <davem@davemloft.net>
CC:     Hongwei Zhang <hongweiz@ami.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [Aspeed,ncsi-rx, v1 0/1] net: ftgmac100: Fix AST2600EVB NCSI RX issue 
Date:   Tue, 15 Dec 2020 14:23:22 -0500
Message-ID: <20201215192323.24359-1-hongweiz@ami.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.98.207]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWyRiBhgq4V7814g6fLBS12XeawmHO+hcXi
        9/m/zBYXtvWxWjSvPsdscXnXHDaLUy0vWBzYPa6272L32LLyJpPHxY/HmD02repk8zg/YyGj
        x+dNcgFsUVw2Kak5mWWpRfp2CVwZx040MBesZqp4eU2wgfENYxcjJ4eEgInEv0VH2LsYuTiE
        BHYxSWxY85QJymGUOH16OxNIFZuAmsTezXPAEiICqxklejb8AmtnFkiXmHThKliRsIC/xKo5
        i1lAbBYBVYm2eZtYQWxeAVOJ2a9+MkGsk5dYveEAM0RcUOLkzCcsEHMkJA6+eAEWFxKQlbh1
        6DFUvaLEg1/fWScw8s1C0jILScsCRqZVjEKJJTm5iZk56eVGeom5mXrJ+bmbGCEBmr+D8eNH
        80OMTByMhxglOJiVRHj/vL0RL8SbklhZlVqUH19UmpNafIhRmoNFSZx3lfvReCGB9MSS1OzU
        1ILUIpgsEwenVANj3SWzPetS6hy+1n384yBeJZj7yf2/c9KtkKlvDRUVQi8yrtx+eWWB51mD
        tKpp6ktSRbUPp7p/eSsR+ONzaN+83Cka6WbFx7ncXsWl9yTcvt/4Z/fs0vyo8pV3tHjPpfH1
        G59kTl6T8nn2/c+aJa+VXG4UX9/tHp9rPTOc2f335PcMe/bEi55UYinOSDTUYi4qTgQA7uk/
        zT4CAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Reviewer,

Fix AST2600 EVB NCSI RX timeout issue by removing FTGMAC100_RXDES0_RX_ERR bit 
from macro RXDES0_ANY_ERROR.

Hongwei Zhang (1):
  net: ftgmac100: Fix AST2600 EVB NCSI RX issue

 drivers/net/ethernet/faraday/ftgmac100.h | 1 -
 1 file changed, 1 deletion(-)

-- 
2.17.1

