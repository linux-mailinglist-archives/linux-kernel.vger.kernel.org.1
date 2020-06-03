Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80511ECB1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 10:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgFCII4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 04:08:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:50612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgFCII4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:08:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B5EDDACE6;
        Wed,  3 Jun 2020 08:08:57 +0000 (UTC)
Date:   Wed, 3 Jun 2020 10:08:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     daniel.thompson@linaro.org, kgdb-bugreport@lists.sourceforge.net,
        jason.wessel@windriver.com, dianders@chromium.org,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] kdb: Check status of console prior to invoking
 handlers
Message-ID: <20200603080853.GB14855@linux-b0ei>
References: <1591168935-6382-1-git-send-email-sumit.garg@linaro.org>
 <1591168935-6382-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591168935-6382-3-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-06-03 12:52:13, Sumit Garg wrote:
> Check if a console is enabled prior to invoking corresponding write
> handler.
> 
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
