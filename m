Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2661A4B64
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 22:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDJUsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 16:48:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJUsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fm247UVIh+HAImQ8X6Ae8I+F49FsdPjugKUAkOuo7Yw=; b=dHe+Vq7wPRzEO74pzBkrbeDk+A
        5FH1BBww1Jgl9HT4OzhzfHz1u5WOa7dsySEaTvckVCmpzLoDOlQEW/M15IbuWLobIkf95BwsmXByL
        MoYg/4MbE6d33DvggWuRPZDurMB5Quwlj7arNnOTtFLJL0eJ8uxN9mbZt2ErGNubY2aPUjslwegYt
        iZn6IdQGJfxeewxDAIJE+5EBnmhmQHbS/BaZ5ysneIqRnbR++tmLae5RhbcOvYudCbDG/4uDf4wtn
        b114ebfvXO3xhTLk8jJSQSDnJD/3Y2Dn/ii467lXiveRl3MDLuCV8qUFmRYV216Ag3hGot6FPVXFL
        TupQeK7w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jN0Zb-0004SG-9S; Fri, 10 Apr 2020 20:48:23 +0000
Date:   Fri, 10 Apr 2020 13:48:23 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Cristian Souza <cristianmsbr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH v3] docs: admin-guide: Clarify sentences
Message-ID: <20200410204823.GB21484@bombadil.infradead.org>
References: <20200410200345.GA36148@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410200345.GA36148@darkstar>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 05:03:45PM -0300, Cristian Souza wrote:
> Changes to make the text more formal and organized. The reasons are now cited and described at the same time.
> Minor grammatical problems have also been fixed.

This looks like a diff against v2, not against mainline.
