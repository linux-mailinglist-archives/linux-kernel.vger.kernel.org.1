Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5997521DA4D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 17:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgGMPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 11:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:40:26 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7200C061755;
        Mon, 13 Jul 2020 08:40:26 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 36116823;
        Mon, 13 Jul 2020 15:40:26 +0000 (UTC)
Date:   Mon, 13 Jul 2020 09:40:25 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Replace HTTP links with HTTPS ones
Message-ID: <20200713094025.180fa813@lwn.net>
In-Reply-To: <20200709191636.26252-1-grandmaster@al2klimov.de>
References: <20200708184201.611d929ae6017c87ea98b114@kernel.org>
        <20200709191636.26252-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Jul 2020 21:16:36 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/kprobes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This file no longer exists in docs-next or linux-next (it's been converted
to RST and moved).  What tree are you making your patches against?

jon
