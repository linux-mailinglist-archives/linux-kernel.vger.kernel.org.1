Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143A91D4E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 14:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgEOM5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 08:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgEOM5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:57:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CE2D2074D;
        Fri, 15 May 2020 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589547423;
        bh=5LfETwNLRvbv2GFgFzYNckimigSr+gEHh5GgDJDslC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zmPFsow88V3GkdL2eRgAfvpUwHPvhHjMh8f6/iry+oQKv+yxVhuNxZ1JNzlJPxvCb
         oxtnBH/CQ8G2XsnNdY63GZwd3hZO/dPdK1/GzdJ5sEioz1dIFQA0mk5XV6a5qJKTld
         l7GZWiq5rWWGlr/FWVRCfGqlfKrnFbUuslue8iNA=
Date:   Fri, 15 May 2020 14:57:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddharth Chandrasekaran <siddharth@embedjournal.com>
Cc:     Siddharth Chandrasekaran <csiddharth@vmware.com>,
        srostedt@vmware.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, srivatsab@vmware.com, dchinner@redhat.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH] Backport security fixe to 4.9 and 4.4 stable trees
Message-ID: <20200515125701.GA1934886@kroah.com>
References: <cover.1589486724.git.csiddharth@vmware.com>
 <20200515124945.GA93755@csiddharth-a01.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515124945.GA93755@csiddharth-a01.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 06:19:45PM +0530, Siddharth Chandrasekaran wrote:
> Please ignore this patch set, I accidentally added another patch I was
> working on. Will send v2 with the right patches.

What patch set?  I see nothing in this email, so I have no idea what you
are referring to :(

greg k-h
