Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66CC2663D7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgIKQ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgIKPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:24:05 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D4DC061371;
        Fri, 11 Sep 2020 07:32:56 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGk6W-00EMOm-ND; Fri, 11 Sep 2020 14:32:44 +0000
Date:   Fri, 11 Sep 2020 15:32:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     tony.luck@intel.com, fenghua.yu@intel.com,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Subject: Re: [PATCH] ia64: remove perfmon
Message-ID: <20200911143244.GA3421308@ZenIV.linux.org.uk>
References: <20200911094920.1173631-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911094920.1173631-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 11:49:19AM +0200, Christoph Hellwig wrote:
> perfmon has been marked broken and thus been disabled for all builds
> for more than two years.  Remove it entirely.

Enthusiastically-ACKed-by: Al Viro <viro@zeniv.linux.org.uk>
