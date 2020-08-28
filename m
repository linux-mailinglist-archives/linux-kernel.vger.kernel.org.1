Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827FB25546E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 08:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgH1GUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 02:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgH1GUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 02:20:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC3032071B;
        Fri, 28 Aug 2020 06:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598595645;
        bh=scjglykxmNbZFUSc67vmSEgE253PfmmwfpBC3STILM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wyMmEdV2cLXm5F3JKjx5n91Zmz9mzIf74jP24ws/FvMT1DvUgZvwWhRdu6l5YIUOF
         b4Y5FzB6QyfxDXdJ+8CCU82xaEMk6gtERrHX1sLeZi2WhZOMDH6QfDAF46i2f/pbWu
         j6dCdAkHslm3XEv7sKnlP6JDdC0aC2HvVmi8xL6Q=
Date:   Fri, 28 Aug 2020 08:20:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qiushi Wu <wu000273@umn.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Kangjie Lu <kjlu@umn.edu>
Subject: Re: Some questions about the patching process
Message-ID: <20200828062042.GF56396@kroah.com>
References: <CAMV6ehGKBfXN89XeDzMHKQ_6qLg41R2Tb7=sE+NC7KrbPsigDw@mail.gmail.com>
 <20200827182730.GA712693@kroah.com>
 <CAMV6ehEwaStF7Xvy-u4p+eU9C1UObCN8eVmuJmVZRFykROdnnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMV6ehEwaStF7Xvy-u4p+eU9C1UObCN8eVmuJmVZRFykROdnnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 02:17:20PM -0500, Qiushi Wu wrote:
> Hi Greg,
> Thanks for your response!

<snip>

You responded in html format which got rejected by the public list,
please resend in text-only and I will be glad to reply.

thanks,

greg k-h
