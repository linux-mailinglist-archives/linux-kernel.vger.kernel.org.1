Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43023232BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 08:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgG3GG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 02:06:57 -0400
Received: from verein.lst.de ([213.95.11.211]:54622 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgG3GG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:06:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12ED068AFE; Thu, 30 Jul 2020 08:06:55 +0200 (CEST)
Date:   Thu, 30 Jul 2020 08:06:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rodrigo Madera <rodrigo.madera@gmail.com>
Cc:     hch@lst.de, christian.brauner@ubuntu.com,
        linux-kernel@vger.kernel.org
Subject: Re: bpfilter logging write errors in dmesg
Message-ID: <20200730060654.GA17803@lst.de>
References: <20200727145013.GA2154@lst.de> <20200730005902.236086-1-madera@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730005902.236086-1-madera@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ho Rodrigo,

please try this patch:

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 1905e01c3aa9a7..4494ea6056cdb8 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -39,7 +39,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 {
 	struct mbox_request req;
 	struct mbox_reply reply;
-	loff_t pos;
+	loff_t pos = 0;
 	ssize_t n;
 	int ret = -EFAULT;
 
