Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1873F20C64B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 07:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgF1Fw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 01:52:27 -0400
Received: from nautica.notk.org ([91.121.71.147]:37248 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgF1Fw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 01:52:26 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7F3F9C01A; Sun, 28 Jun 2020 07:52:25 +0200 (CEST)
Date:   Sun, 28 Jun 2020 07:52:10 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        wei.chen@arm.com
Subject: Re: [RFC PATCH 2/2] 9p: remove unused code in 9p
Message-ID: <20200628055210.GA13335@nautica>
References: <20200628020608.36512-1-jianyong.wu@arm.com>
 <20200628020608.36512-3-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200628020608.36512-3-jianyong.wu@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Sun, Jun 28, 2020:
> These code has been commented out since 2007 and lied in kernel
> since then. it's time to remove thest no used code.

Good point, happy to take this - please resend without RFC separately
(the two commits aren't related) after fixing the commit message
(lie/lay is complicated and I'm not sure what should be used there but
lied definitely isn't correct, the qualification doesn't really matter
though so probably simpler to remove; and 'thest no used code' does not
parse)

-- 
Dominique
