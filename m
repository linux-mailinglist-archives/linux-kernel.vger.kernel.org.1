Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E3F1CAD53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgEHNAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 09:00:47 -0400
Received: from sonic317-28.consmr.mail.bf2.yahoo.com ([74.6.129.83]:45290 "EHLO
        sonic317-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728734AbgEHMwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588942331; bh=89EXGloTSE7qg19c2KdooPMjKT4q6ONR66TAwXPeW2w=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Eff+x6s9ZXCEXjIuecez/p5SRbZ1bz0j2Sxp4+qTKHLC0lm0pfFINY831fTKLr3aJar3xX4NLPrDEtqWiLrqxH0IyG8+X46wFx41D5UsjcWzGmQrkBEAawmgaHzm4YesPjtXRoecojNKXFrEgIx+QdNQWoZ7nnkkUmIFg0vIuwCLVaPjPSbZfhdLf4DuCbER2pRXRogI076L8saY6C+xMq10pm1tXym2KlV7a3TqbNPtmBUqW9s0hvZQ9WNBXTtnX4DJhcDe9Y1N7srJS1d/YuYs9W103nIgdH7KCxULLOHfw6ostanu9+poE26Au8d0PDVOWaPTUA9ZLUeXwuMFLA==
X-YMail-OSG: UrlEaTsVM1k2hmyYuP1_L7IcFZm7GXTubDZ55Xo46cCdWAhrje5O8VITQ77nPlC
 FPTf0n0Zonxba9uIg0aGp7Ln6wfuDRYUehHroqdAIuNNveJdqHcY5zWSF4RDPAWQ46h0BadNnVFM
 RcJN1TWMAx9cRmeKErFVXaS9G8BB2cR9Jpn744MWQMLWvgUWOKIYEO_nn4AXXxDAiLNHL8UKJSPK
 R2sdcyt99PABK.bcKsk5JhfneUsAWYruyDlywTuLNcZrrWA1hLStYU9reeICjXGwpzcS2TRKiviI
 nIqS91FBZ9hZn6YHtjZXkcCLkBUrAnYBRW5f0.J17YEvUxB8PSERbBbmWj9J61gkII68BfMgo37r
 Oe83mXw2fRlTlAvKZc17Ooz1clc6_AFa_p_BXtPi4paSv3mLoWarAILb8xfHo7G4FUZ8ipdnRCk3
 6XayRzluT4bVFlH.QPo0u_vNoQUgHBwcpdFXPhQkdr.8yrGXlc.CDTjJd0EdvAgPJWyUJmBPzYLb
 ZGQiy4KwpS2dUZw5bxpRnYYJM4fL27UqQn1xq8qvr6VpASReLSz8gHyN_qQsF5VCldN3IOjzbk80
 DH6A50Edwqm1eJDZA9QKt0iHnn.kG2GfHVTSSLu8MkEPF2XZfRmRXLIUX3BCR0QtpYR1KwyECuBI
 Q6TTSlSr7iwLXmQN6y_XQrYkVZUp0qPYnB8nf1p7q83sfrTDxRNYm0EBp2oHWpxk27k8GMJh6X0I
 HMoz3nNxQUGrhtYyxvTkvxSZOANF6yP3cOFycx0dhdJIapojP.ThywsDMwb5bCEpq0DZFG7P1cBg
 lxOyixqiCLFSlvANFQKtFxqp1yWu6fgr76ypZFJu39SotoqhVFZrP_gWdLD3t3.0hxOZaBNVWTDc
 y6O8fu6PyMbDkgxED1DPj0ER5qSkOlID7SQNKygV0ADhmziYBHAVoDgLdfndVTDI.S5oPu9OAC1R
 deYt2gb2jG.zZFgEB0KSoox9sjnh83FT5Q2Jfoow4BUuXS.pQru6HE4aUD5Auwm725kKqMZ4889T
 cDhJq5vwRnjBdN9hSj7G30RXDXBjGXj0kRVWKH0Wh3dtRe4QURdfSVdfiKFgFTwUeVjZeJzcQUWC
 L3pbk1tJEfcdxgM_3BLP0Pk8qE11oqiqUPvE6LgFHx0ugJjzr8WEXxcNUGSIX_P3ONnS6NqLBfer
 SZMwtxAtGfp2NFGt2zmgM5RZmVVZgQp_JPeCeXysVW81hQo5CfHoUDykTZrQS.jpGvMjW6C_Nwtk
 0h3glHOHGmnpn5VZwyD3E_pKdcXy1wKDtbjibK6_mWFt12_dh9osXukycl.B8RY3dSg0xPw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 8 May 2020 12:52:11 +0000
Date:   Fri, 8 May 2020 12:52:07 +0000 (UTC)
From:   Christopher Bernard <carpetplus@frontiernet.net>
Reply-To: christopherbernard589@gmail.com
Message-ID: <438682369.78425.1588942327986@mail.yahoo.com>
Subject: hi
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <438682369.78425.1588942327986.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15902 YMailNodin Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings
I sent a letter to your mail, but did not receive a response from you
Regards,
Christopher Bernard
