Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBBD20B337
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 16:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgFZOGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 10:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728751AbgFZOGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:06:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8CFF207D8;
        Fri, 26 Jun 2020 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593180392;
        bh=TZwCGCOa3LUlj/xxxjkGf+d/fTdxdJctWFdj95L2Fgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ka9hJZcgtTRLWsURZHl2zEV7TV6kZs8JPFqyjX0MgB7gSxtfW64m1azyAWIos/+9+
         TiW8EudVdxl6yFyVBcB2DA6XbuyiY4rv4UHf2TtNXsu4NzQDl8Wid3PNtRh5jwA16s
         FqffWFnSmorN3dMbjiiwo1HIIcY1r5jXLUkW8n3I=
Date:   Fri, 26 Jun 2020 16:06:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] habanalabs fixes pull request for kernel 5.8-rc2
Message-ID: <20200626140627.GA4135552@kroah.com>
References: <20200624115539.GA8680@ogabbay-VM>
 <CAFCwf12oLixsX_Nz0RsXh_orD5iW4uyXMwuWDxQjfkDJgLQ3yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12oLixsX_Nz0RsXh_orD5iW4uyXMwuWDxQjfkDJgLQ3yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 04:48:45PM +0300, Oded Gabbay wrote:
> Hi Greg,
> Pinging you about this pull request to merge for -rc3

Patience...

