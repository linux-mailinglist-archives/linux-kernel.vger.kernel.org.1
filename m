Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442B41DBA73
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 19:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgETRCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 13:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:02:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77936C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wKFuUlL7y/Hz3vNl2ArSrtbtHfVShgj63vVocK+vAT4=; b=mFGJE3B/bWr+OnkaK0M7OgjxVz
        wGGnFeNf+j/uHBys9ZDrrxgbINOWDtHhpS2HfeOtHJcmou1tqjHmTpEIpdCiNZdePR1tp03BecMJ0
        KTf2waZP87WxMoPBHf8tXVMtZhGXfsLoWEtU8rxQBitP8mWvtAhnjzrDuTsWNIDGtH5ITb+0/z5G8
        X6gx+BQ+6aQSQTMugFQDbL6YAb6gWqKMkMfoJ3iuTH8hjh1paZm2IBbibjPpmXB6C0oRRmxwQ3lZ/
        neobDsvt/oWDkXcKVM9Y+hHH0GX22YdvPDX2USArnwlumE5N1EBCLNolK6CQotjua6vhR/iOCFCb9
        auljKSPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbS6R-0000C5-R2; Wed, 20 May 2020 17:01:59 +0000
Date:   Wed, 20 May 2020 10:01:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RESEND PATCH v7 2/5] seq_buf: Export seq_buf_printf() to
 external modules
Message-ID: <20200520170159.GA22544@infradead.org>
References: <20200519190058.257981-1-vaibhav@linux.ibm.com>
 <20200519190058.257981-3-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519190058.257981-3-vaibhav@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/seq_buf: Export seq_buf_printf() to external modules/
  seq_buf: export seq_buf_printf/
