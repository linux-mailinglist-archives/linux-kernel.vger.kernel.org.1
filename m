Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8436E1CB0AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 15:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgEHNnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 09:43:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgEHNnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:43:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49JWkk2BXVz9sT2;
        Fri,  8 May 2020 23:43:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588945424;
        bh=p+YBkyP2GHp01pThlHZu2zNE3/neu24osdVU16EmOus=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=myzmSBT/czcoOa5b0uNfJvnSn0EcensBRxDGTXSXsFZHz7Ctw4cmolttivclZzczn
         TlU4xQX1sFeEGOftI9Vt/Yg7n9poabHDRrJD9dFFlDt9HOZEqTv21AH+l6TCSACJ+G
         LzS3HI2pTjb4HspWPolQxP9uBnlTFgDZQ6ylB+dBKG4qPpkcOlxszBgodBCGGUmAFz
         Q93GiXrPMyhMZQGgNOXOYLEcRd+vvVE96ReVfh9QW0MP4ysX2iPOSugJKl/xbhnJGC
         +t49vCyjdXj2x+CfQrmiPjxrxBDghm8z3dEzePmFlSG9Pl3oO4Ea39uGSlgu+ZudGZ
         ayiGjaAF21wwA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Borislav Petkov <bp@alien8.de>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v7 2/5] seq_buf: Export seq_buf_printf() to external modules
In-Reply-To: <20200508113100.GA19436@zn.tnic>
References: <20200508104922.72565-1-vaibhav@linux.ibm.com> <20200508104922.72565-3-vaibhav@linux.ibm.com> <20200508113100.GA19436@zn.tnic>
Date:   Fri, 08 May 2020 23:44:00 +1000
Message-ID: <875zd6czj3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:
> On Fri, May 08, 2020 at 04:19:19PM +0530, Vaibhav Jain wrote:
>> 'seq_buf' provides a very useful abstraction for writing to a string
>> buffer without needing to worry about it over-flowing. However even
>> though the API has been stable for couple of years now its stills not
>> exported to external modules limiting its usage.
>> 
>> Hence this patch proposes update to 'seq_buf.c' to mark
>> seq_buf_printf() which is part of the seq_buf API to be exported to
>> external GPL modules. This symbol will be used in later parts of this
>
> What is "external GPL modules"?

A module that has MODULE_LICENSE("GPL") ?

cheers
