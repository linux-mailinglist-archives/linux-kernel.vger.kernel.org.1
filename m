Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89106268450
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgINGAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:00:52 -0400
Received: from nautica.notk.org ([91.121.71.147]:60812 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgINGAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:00:52 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 233D8C009; Mon, 14 Sep 2020 08:00:51 +0200 (CEST)
Date:   Mon, 14 Sep 2020 08:00:36 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>, Greg Kurz <groug@kaod.org>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        justin.he@arm.com
Subject: Re: [PATCH RFC 1/4] fs/9p: fix create-unlink-getattr idiom
Message-ID: <20200914060036.GA18115@nautica>
References: <20200914033754.29188-1-jianyong.wu@arm.com>
 <20200914033754.29188-2-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914033754.29188-2-jianyong.wu@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Mon, Sep 14, 2020:
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>

Just on a note on that mail: gkurz@linux.vnet.ibm.com has no longer been
working for a while, probably want to update to groug@kaod.org in both
first two patches.
Greg, sorry I had forgotten to fix Cc earlier, can you confirm?


I'll (re)do a proper review of the first three patches again in a bit
but iirc they looked good on paper, will resend a mail if required.

-- 
Dominique
