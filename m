Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5546D1ABA79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440569AbgDPHzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:55:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440362AbgDPHyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:54:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15DFD2076A;
        Thu, 16 Apr 2020 07:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587023690;
        bh=DEDM2KwFQ+vK11ji7RyEGWJ1qKcgpykTe24bEkqIMTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2JXnCW5ud3M1WCKHv0FTA99c5lDGDffGfJz/0nsYzOwXucJujy40mOpDCM/HR5YtE
         mLly2mbUzjsj1VOxMMEh7+txROmajytDlAu8QrHDQXrhh7JOozt+JdeKhkuE4s1u4C
         yHZ9+ErK34iBsag9LAUffMWICV1dzSdI7EYhMPLU=
Date:   Thu, 16 Apr 2020 09:54:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] bdi: remove the name field in struct backing_dev_info
Message-ID: <20200416075448.GH376871@kroah.com>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416071519.807660-9-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:15:19AM +0200, Christoph Hellwig wrote:
> The name is only printed for a not registered bdi in writeback.  Use the
> device name there as is more useful anyway for the unlike case that the
> warning triggers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
