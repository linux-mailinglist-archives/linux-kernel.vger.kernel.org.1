Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FDA2E30AC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 11:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgL0KEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 05:04:07 -0500
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:1984 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgL0KEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 05:04:06 -0500
X-Greylist: delayed 3150 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Dec 2020 05:04:04 EST
Received: from thorin.petrovitsch.priv.at (80-110-120-193.cgn.dynamic.surfer.at [80.110.120.193])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id 0BR9AKEH028348
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 27 Dec 2020 10:10:29 +0100
Message-ID: <e3907945567e25a34c38ef413ab09cd05c8ad43c.camel@petrovitsch.priv.at>
Subject: Re: linux.git is broken on a case-insensitive filesystem
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
To:     Theodore Dubois <tblodt@icloud.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 27 Dec 2020 10:10:13 +0100
In-Reply-To: <080A3B31-608F-4A36-A5DE-B75670D2452E@icloud.com>
References: <080A3B31-608F-4A36-A5DE-B75670D2452E@icloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-DCC--Metrics: esgaroth.tuxoid.at 1481; Body=2 Fuz1=2 Fuz2=2
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
X-Spam-Status: No, score=0.4 required=5.0 tests=AWL,BAYES_50,UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.1
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 UNPARSEABLE_RELAY Informational: message has unparseable relay lines
        * -0.4 AWL AWL: Adjusted score from AWL reputation of From: address
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on esgaroth.tuxoid.at
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On Sat, 2020-12-26 at 14:30 -0800, Theodore Dubois wrote:
[...]
>  thing on macOS (please don't question my sanity :), and I've run
>  into various issues stemming from macOS having a case-insensitive
>  filesystem. 

Case-insensitive filesystems are broken by design.

Kind regards,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
There is no cloud, just other people computers. - FSFE
                     LUGA : http://www.luga.at


