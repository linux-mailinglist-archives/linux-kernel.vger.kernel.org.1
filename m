Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFB623CFF0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 21:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgHET0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 15:26:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:46838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbgHERNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:13:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B54CB588;
        Wed,  5 Aug 2020 12:53:55 +0000 (UTC)
Date:   Wed, 5 Aug 2020 14:53:57 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     broonie@kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] selftests: vdso: hash entry size on alpha, s390x
 is 8 bytes
Message-ID: <20200805125357.GE5522@yuki.lan>
References: <9927ed18c642db002e43afe5e36fb9c18c4f9495.1594811090.git.jstancek@redhat.com>
 <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
As much as it's worth the changes looks good to me.

@Jan: I guess that we can as well fix this in LTP first then we can try
      to get the kernel version fixed...

-- 
Cyril Hrubis
chrubis@suse.cz
