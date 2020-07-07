Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2983217A94
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 23:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgGGVer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 17:34:47 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:44493 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728357AbgGGVer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:34:47 -0400
Received: from [78.134.117.153] (port=57056 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jsvEh-000Gqt-Ju; Tue, 07 Jul 2020 23:34:43 +0200
Subject: Re: [PATCH V2] clk: vc5: Add memory check to prevent oops
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     dan.carpenter@oracle.com, aford@beaconembedded.com,
        charles.stevens@logicpd.com, Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <20200706203727.18380-1-aford173@gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <128e24e8-ae83-0b0f-8771-28a67f6d8586@lucaceresoli.net>
Date:   Tue, 7 Jul 2020 23:34:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200706203727.18380-1-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 06/07/20 22:37, Adam Ford wrote:
> When getting the names of the child nodes, kasprintf is used to
> allocate memory which is used to create the string for the node
> name.  Unfortunately, there is no memory check to determine
> if this allocation fails, it may cause an error when trying
> to get child node name.
> 
> This patch will check if the memory allocation fails, and returns
> and -NOMEM error instead of blindly moving on.

s/-NOMEM/-ENOMEM/

With this possibly fixed:
Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
