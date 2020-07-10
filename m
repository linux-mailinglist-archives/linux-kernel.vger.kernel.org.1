Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ABC21BA9C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgGJQPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:15:37 -0400
Received: from verein.lst.de ([213.95.11.211]:43919 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbgGJQP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:15:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE2D268AEF; Fri, 10 Jul 2020 18:15:27 +0200 (CEST)
Date:   Fri, 10 Jul 2020 18:15:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: user_access_{save,restore}() semantics
Message-ID: <20200710161527.GA22579@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

can you explain (and maybe document while we're at it) what the
exact semantics of the user_access_{save,restore} helpers are?

Reverse engineering from the commit text they seem to be about
saving the current uaccess state.  But do they also enable/disable
anything?
