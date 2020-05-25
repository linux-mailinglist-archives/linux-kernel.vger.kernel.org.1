Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0E1E1463
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 20:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389696AbgEYScy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 14:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389505AbgEYScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 14:32:54 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0541BC061A0E;
        Mon, 25 May 2020 11:32:54 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 32518455A2;
        Mon, 25 May 2020 18:32:50 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
To:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200520200037.88705-1-grandmaster@al2klimov.de>
 <20200525102825.63d72ed2@lwn.net>
 <0b3b5ae5-457a-b550-63a8-08a77bb862d7@al2klimov.de>
 <7b93effe211b5439b6b8697e8ed3a2b070bfbb31.camel@perches.com>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <a76c1008-261d-5f0f-f739-e8cebf7610ac@al2klimov.de>
Date:   Mon, 25 May 2020 20:32:48 +0200
MIME-Version: 1.0
In-Reply-To: <7b93effe211b5439b6b8697e8ed3a2b070bfbb31.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 25.05.20 um 20:24 schrieb Joe Perches:
> On Mon, 2020-05-25 at 20:01 +0200, Alexander A. Klimov wrote:
>> Does it matter whether I just feed the output of ...
>>
>> perl scripts/get_maintainer.pl --separator , --norolestats
>> 0001-Replace-HTTP-links-with-HTTPS-ones-documentation.patch
>>
>> ... into Git send-email To: prompt or actually CC: (not To:) mailing lists?
> 
> Yes.  vger mailing lists drop emails with large to:/cc:
> headers (It was >1024 chars, it may be different now)
Good to know.

> 
> It's generally better to add --nogit --nogit-fallback to
> get_maintainer to avoid the git lookup addition of people
> that have modified files that aren't listed in MAINTAINERS.
Really? I used them for a previous version of my patch, but Jon (who 
didn't use that params) complained about too many people not being CCed.

As Jon now applied (whatever branch on...) my patch, I assume that not 
using those params is better.

After all not using them doesn't enlarge the set of recipients per patch 
(of mine), but reduces patch size as I group changed files per set of 
recipients.

> 
> You could add a --bcc with those dropped names if you
> really want to have those people receive the emails.
> 
