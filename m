Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0491EBF6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 17:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgFBPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 11:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgFBPzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:55:08 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CDFD2067B;
        Tue,  2 Jun 2020 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591113308;
        bh=PRxYptlqDh/ho5Adpy8HLDZHSmhfvJbp9cjTmMciy58=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rqolI2+cJdcgCjFb938OQrKwiPnmVdg09hq9mw0rg3s/2xntd5muOFt2qIOjCU6yt
         JL5oyl+4M1uHTMXcV7sDlr3yTxMpdCvOXSYOxOHXfujuQRMO5vZEztUqutLOtD3Atb
         GDB+AIu2CqT/LfTdGrDSRzpjlKflJrrfpVV6Seho=
Date:   Tue, 2 Jun 2020 08:55:07 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        ericvh@gmail.com, lucho@ionkov.net,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2] 9p/xen: increase XEN_9PFS_RING_ORDER
In-Reply-To: <20200602060246.GA16791@nautica>
Message-ID: <alpine.DEB.2.21.2006020855010.12801@sstabellini-ThinkPad-T480s>
References: <20200521193242.15953-1-sstabellini@kernel.org> <20200522055847.GA2833@nautica> <alpine.DEB.2.21.2006011406100.12801@sstabellini-ThinkPad-T480s> <20200602060246.GA16791@nautica>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020, Dominique Martinet wrote:
> Stefano Stabellini wrote on Mon, Jun 01, 2020:
> > > LGTM, I'll try to find some time to test this by the end of next week or
> > > will trust you if I can't make it -- ping me around June 1st if I don't
> > > reply again until then...
> > 
> > Ping :-)
> 
> I actually did think about this patch this weekend! . . .but didn't
> quite make it :/
> Anyway, as promised pushed to linux-next, I'll submit this for 5.8

Thank you!
