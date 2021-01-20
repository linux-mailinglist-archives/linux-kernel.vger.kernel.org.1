Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A3C2FCFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbhATLlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbhATLHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:07:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C094F22227;
        Wed, 20 Jan 2021 11:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611140824;
        bh=QWF5nEtfs5dfeK61ZXtr8nwYqBak9brMmBKpQfTzo3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGKF5yiRqXtsaNb06/qRTXHd75ln7RoxqM9SZUS8T3aFMxzflrOw72qyMGQmHwqkF
         JSOYYS+azIv29jW/LjenHJargGVFEk8sbymhxcihthn2R7q8ARDhr4+94bYo/NSWJR
         cDyHqtPYn/po6XoyU4/0TximoZlFJgtvgqGQrUoN6n0wnW5sF7hDxEjOQckq6nGNc3
         DdhfUOauPIgWOfWBe+5gXvSSYJwxJYQ90i9RlnbPX8pIvGvHg5xqivlual0FPwQ7hX
         XjlIkbef0RBM9qTOQrKo2SH2PyeYtlUMXSvWKJ4Za2s5ucjPkf04kX/GN8SyalrgQJ
         g3ebNrZYQrYFg==
Date:   Wed, 20 Jan 2021 11:07:00 +0000
From:   Will Deacon <will@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com
Subject: Re: [PATCH] locking/rwsem: Remove empty rwsem.h
Message-ID: <20210120110659.GA19241@willie-the-truck>
References: <20210113152022.772555-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113152022.772555-1-nborisov@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 05:20:22PM +0200, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Maybe mention some of the history in the commit message? (i.e. which commits
removed all of the contents of this file).

Will
