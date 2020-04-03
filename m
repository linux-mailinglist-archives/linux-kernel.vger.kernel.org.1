Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E68D719D126
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 09:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbgDCHZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 03:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730889AbgDCHZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:25:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93E96206F8;
        Fri,  3 Apr 2020 07:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585898710;
        bh=UrW0qh9b86HOoFRZ6/gp1zp7+bI3Pc9plhScThk4b/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPaopi7JNVueL99fqC5I2IPOvDiw5PKfVqx9nnXQdh4jBpwLu6GA5N+MIjudjKghG
         2rDOnIj44L9SSeMWA/kfFvQngwKidFl6YHO0Xhakwt8GUBA2/TjpIPM5idzX/gvI56
         ZegQxlDn6+iLUFYFEI8XXnz2kAs3z0qtrFjZMGYQ=
Date:   Fri, 3 Apr 2020 09:25:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: gasket: Fix comment 75 character limit
 warning
Message-ID: <20200403072502.GD3405737@kroah.com>
References: <20200402053617.826678-1-jbwyatt4@gmail.com>
 <20200402053617.826678-3-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402053617.826678-3-jbwyatt4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 10:36:17PM -0700, John B. Wyatt IV wrote:
> Fix 75 character limit warning in comment reported by checkpatch.

comments are not allowed to go beyond 75 columns now?  Is that something
new?

The code is fine as-is, sorry.

thanks,

greg k-h
