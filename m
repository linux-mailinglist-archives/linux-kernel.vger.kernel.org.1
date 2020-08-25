Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D2B251268
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 08:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgHYGwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 02:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbgHYGwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:52:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 499412076C;
        Tue, 25 Aug 2020 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598338332;
        bh=ajZvLj9BjR77Id3A98oIhcvcaL+SUw6LfKF/69V/kLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AN/lXcIxfDf5rJ39XYKzwtM/ZtuUuqNlw9WEZeCXlOiC9jx4t9aMg77SIGfl10uMU
         ObFPWpLwJv5bhPB7R2iP4LeNNf7JDyEjiQC2oN8EotTe6EtwKeba74Go7XyM5zqMD2
         aGjmG54a6XqEz1QwkWRq6eGNYuQuTecuhWBektsM=
Date:   Tue, 25 Aug 2020 08:52:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Tomer Samara <tomersamara98@gmail.com>, devel@driverdev.osuosl.org,
        Todd Kjos <tkjos@android.com>,
        Riley Andrews <riandrews@android.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Arve Hj?nnev?g <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v4 0/2] staging: android: Remove BUG/BUG_ON from ion
Message-ID: <20200825065229.GA1319770@kroah.com>
References: <cover.1598023523.git.tomersamara98@gmail.com>
 <20200825064729.GA30014@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825064729.GA30014@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 07:47:29AM +0100, Christoph Hellwig wrote:
> On Fri, Aug 21, 2020 at 06:27:04PM +0300, Tomer Samara wrote:
> > Remove BUG/BUG_ON from androind/ion
> 
> Please just remove ion.  It has been rejected and we have developed
> proper kernel subsystens to replace it.  Don't waste your time on it.

It is going to be removed at the end of this year.  Why we keep it
around until then, I really don't know, but John and Laura have this as
the plan.

thanks,

greg k-h
