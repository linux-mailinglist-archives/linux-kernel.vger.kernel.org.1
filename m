Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BC32AFC44
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgKLBeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:34:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbgKKW5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:57:22 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFE22072C;
        Wed, 11 Nov 2020 22:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605135441;
        bh=VPpBI4DLSnoWPj8x+lszpIP40asm1HTFF4ON1H5/z98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cF4wZi47/iYP9AeqaRta9P0IHiayGUJlol/cxKBQuRL7lu5c5IvH4DqaxU5jMJ7Bc
         abtHokQPMEMiu8IZpI5HB8DMr4esvnrTupjK0Hpj/2OeRwNZEMREvOcWTTvchWwA+A
         1P1k7TMdO0u28BV41U5SJRB6aKa9Mq4M3vQGJHJY=
Date:   Wed, 11 Nov 2020 14:57:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Xie He <xie.he.0141@gmail.com>
Cc:     Martin Schiller <ms@dev.tdt.de>, andrew.hendry@gmail.com,
        davem@davemloft.net, edumazet@google.com, xiyuyang19@fudan.edu.cn,
        linux-x25@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] net/x25: Fix null-ptr-deref in x25_connect
Message-ID: <20201111145720.0c743104@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201111115947.3498-1-xie.he.0141@gmail.com>
References: <20201109065449.9014-1-ms@dev.tdt.de>
        <20201111115947.3498-1-xie.he.0141@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 03:59:47 -0800 Xie He wrote:
> > @@ -825,7 +825,7 @@  static int x25_connect(struct socket *sock, struct sockaddr *uaddr,
> >  	sock->state = SS_CONNECTED;
> >  	rc = 0;
> >  out_put_neigh:
> > -	if (rc) {
> > +	if (rc && x25->neighbour) {
> >  		read_lock_bh(&x25_list_lock);
> >  		x25_neigh_put(x25->neighbour);
> >  		x25->neighbour = NULL;  
> 
> Reviewed-by: Xie He <xie.he.0141@gmail.com>

Applied, thanks!
