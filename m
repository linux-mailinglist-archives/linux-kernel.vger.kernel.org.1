Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648572222B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgGPMnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:43:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:39074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPMny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:43:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87F1AADC4;
        Thu, 16 Jul 2020 12:43:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Jul 2020 14:43:53 +0200
From:   osalvador@suse.de
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, linux-mm@kvack.org, mike.kravetz@oracle.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
        ashok.raj@intel.com, dave.hansen@intel.com, arjan@linux.intel.com,
        torvalds@linux-foundation.org, peterz@infradead.org, bp@alien8.de,
        pbonzini@redhat.com, tim.c.chen@linux.intel.com,
        gregkh@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] x86/speculation: Add basic IBPB (Indirect Branch
 Prediction Barrier) support
In-Reply-To: <20200716123810.25292-17-osalvador@suse.de>
References: bnc#1012382 <20200716123810.25292-17-osalvador@suse.de>
User-Agent: Roundcube Webmail
Message-ID: <3300e32e2782f8521ba81234535b5c84@suse.de>
X-Sender: osalvador@suse.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-16 14:38, Oscar Salvador wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>

Sorry for the noise.
This should not be here.

I dunno how this patch sneaked in.

Please ignore it.



