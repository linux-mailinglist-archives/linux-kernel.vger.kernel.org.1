Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD74284F44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJFPwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:52:23 -0400
Received: from verein.lst.de ([213.95.11.211]:34576 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFPwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:52:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3FBDC67373; Tue,  6 Oct 2020 17:52:21 +0200 (CEST)
Date:   Tue, 6 Oct 2020 17:52:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     WeiXiong Liao <gmpy.liaowx@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: use case for register_pstore_blk?
Message-ID: <20201006155220.GA11668@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi WeiXiong, hi Kees,

what is the use case for the code added in commit 17639f67c1d6 
("pstore/blk: Introduce backend for block devices").

This still doesn't have a user, and the API looks really odd to me.
By our normal kernel rules we should not add new exports without
users and this should probably be reverted for the 5.9 release.
