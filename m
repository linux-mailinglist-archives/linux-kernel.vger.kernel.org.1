Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F882D1349
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgLGOM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgLGOM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:12:57 -0500
Date:   Mon, 7 Dec 2020 15:13:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607350337;
        bh=IBMlOSU2iIQucQDXTYzzOosHVlluTgpzB+poKtRcw9w=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=wwl07o6i4DTkUBy150n/O9L5A0sK2A7T2brGedOTzb2xqUS9Me31gjT1yipnbAtp3
         rDE80owzb5nA/pXqKIE6wyyECAqYBZL1Bt7O2mFYpeEVLRsVntmF+1gdmhl6eAihwq
         b274GpcaxnQ8E+8T9GikVP0OHJrbkxUcnB8XPL28=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ross Schmidt <ross.schm.dev@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] staging: rtl8723bs: replace unique macros and
 ELEMENT_ID
Message-ID: <X844h0efBCbQ0yrw@kroah.com>
References: <20201206034517.4276-1-ross.schm.dev@gmail.com>
 <20201206034517.4276-10-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206034517.4276-10-ross.schm.dev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 09:45:17PM -0600, Ross Schmidt wrote:
> Replace unique macros and ELEMENT_ID with kernel provided ieee80211_eid
> enum.
> 
> In a several cases multiple macros or constants are replaced by one
> constant.
> 
> WLAN_EID_HT_CAP, _HT_CAPABILITY_IE_, and EID_HTCapability are replace by
> WLAN_EID_HT_CAPABILITY.
> 
> _WPA2_IE_ID_, EID_WPA2, and _RSN_IE_2_ are replaced by WLAN_EID_RSN.
> 
> _HT_EXTRA_INFO_IE_ and _HT_ADD_INFO_IE_ are replaced by
> WLAN_EID_HT_OPERATION.
> 
> WLAN_EID_GENERIC, _WPA_IE_ID_, _SSN_IE_1_, and _VENDOR_SPECIFIC_IE_ are
> replaced by WLAN_EID_VENDOR_SPECIFIC.
> 
> Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>

All other patches in this series applied cleanly, please rebase this one
and resend.

You might want to break it up into one-patch-per-constant replacement

thanks,

greg k-h
