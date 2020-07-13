Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCFA21DF69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 20:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgGMSNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 14:13:07 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2428 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbgGMSNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:13:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0ca3f90000>; Mon, 13 Jul 2020 11:12:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 11:13:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 Jul 2020 11:13:06 -0700
Received: from [10.26.72.101] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 18:13:05 +0000
Subject: Re: [PATCH] debugfs: add a proxy stub for ->read_iter
To:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200713073729.875584-1-hch@lst.de>
 <20200713073729.875584-2-hch@lst.de> <20200713083811.GA215949@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ad8c7b5e-d0f2-6652-a08d-7a3556e0d65d@nvidia.com>
Date:   Mon, 13 Jul 2020 19:13:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200713083811.GA215949@kroah.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594663929; bh=J7suhPfdUbeZ60z9NjDWk6VD1EZnR9bMDsBHYI8J4/k=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZsShWRFMN6U0gdQtwIC6AC27PZk7seOTdYVKm1GGMkXaeyhoOBjUVKq7ICgHgr+Tp
         dybKHvglKCByK8dUBUAEtekRy2l1KnlKdyfEUAZeudmlvG000ewKXRtYZxMLX91ICv
         tty9wwqnnrXDv97Cu6fk8y6wFLTkAY50ds4wPC6oNB/+W70VT+W64wfzmpfqWnEHbA
         ALe7uc3MJrbASdkUwfzM23uWM76/SNZ3JFFq0XbrLkITiqpiINArdwTRbCKb4iFpYu
         RrPIU8uTQP3pKeX13TL3ikYjLI8BTjjc/Rsq1yi7S9H3TlLNNbc9Wuy17z4hsz6fc/
         iIZGgA/+eVe4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/07/2020 09:38, Greg KH wrote:
> On Mon, Jul 13, 2020 at 09:37:29AM +0200, Christoph Hellwig wrote:
>> debugfs registrations typically go through a set of proxy ops to deal
>> with refcounting, which need to support every method that can be
>> supported.  Add ->read_iter to the proxy ops to prepare for seq_file to
>> be switch to ->read_iter.
>>
>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 


Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

