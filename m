Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269AD1CE53B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgEKUR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgEKUR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:17:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0138C206E6;
        Mon, 11 May 2020 20:17:57 +0000 (UTC)
Date:   Mon, 11 May 2020 16:17:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, mingo@redhat.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] s390: Remove two unused inline functions
Message-ID: <20200511161756.7586afe6@gandalf.local.home>
In-Reply-To: <20200511060750.GA93884@tuxmaker.boeblingen.de.ibm.com>
References: <20200508140724.11324-1-yuehaibing@huawei.com>
        <20200511060750.GA93884@tuxmaker.boeblingen.de.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 08:07:51 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Thanks for noticing, looks like i missed them.
> 
> Acked-by: Sven Schnelle <svens@linux.ibm.com>

As this is s390 specific, will it be going through the s390 repo?

-- Steve
