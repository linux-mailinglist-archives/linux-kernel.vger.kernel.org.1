Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45425218C67
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgGHP77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 11:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730048AbgGHP76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:59:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1940A206F6;
        Wed,  8 Jul 2020 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594223998;
        bh=rBZpg1h1etUepJiMk2nTuvsUlvGjGpwam/EsGvShVeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2E9tj82hdsVJd/Knq9HCxyHtB9SMYC3qV96m414g9momr6z/Z9mU4kDQeh8wQWPYC
         Ctlo1UbuN5Q1HLg34m9D/pt9s+0H36ATAfh0nsouniFjRrpwXSMICEZAArqYsCiGK1
         kOB3EGIkjwyhbUe+EO97zov8ElMAgxk+GDvE8uVI=
Date:   Wed, 8 Jul 2020 17:59:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] soundwire: fixes for 5.8
Message-ID: <20200708155954.GA720524@kroah.com>
References: <20200707042750.GB676979@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707042750.GB676979@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 09:57:50AM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> Please pull to receive a single fix for Intel driver
> 
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.8-fixes

Pulled and pushed out, thanks.

greg k-h
