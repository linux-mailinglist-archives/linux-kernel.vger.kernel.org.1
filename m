Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944081E7FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgE2OJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 10:09:11 -0400
Received: from verein.lst.de ([213.95.11.211]:33175 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgE2OJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:09:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A711A68B02; Fri, 29 May 2020 16:09:07 +0200 (CEST)
Date:   Fri, 29 May 2020 16:09:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: please revert "Revert "media: staging: atomisp: Remove driver""
Message-ID: <20200529140907.GA2916@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro and Greg,

the commit mentioned in the subject (commit id ad85094b293e in
linux-next) contains the grave offense of adding a new set_fs address
space override in "new" code.  It also doesn't have an Ack from Greg
despite showing up in drives/staging, which looks very suspicious.

Please don't just add crap like this back if it doesn't pass the
most basic sanity tests.
