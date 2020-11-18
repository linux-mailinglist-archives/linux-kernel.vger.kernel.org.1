Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99192B7417
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgKRCCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:02:15 -0500
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:34520 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726215AbgKRCCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:02:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A4858100E7B43;
        Wed, 18 Nov 2020 02:02:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:4321:5007:7514:7974:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12555:12740:12895:12986:13439:13894:14096:14097:14181:14659:14721:21080:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: knee23_130af6d27336
X-Filterd-Recvd-Size: 3831
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Nov 2020 02:02:12 +0000 (UTC)
Message-ID: <6447e7bc3515da26ab7f1b02ed178a6859af789a.camel@perches.com>
Subject: Re: [PATCH] net: ipv4: fixed a brace coding style issue
From:   Joe Perches <joe@perches.com>
To:     Armin Gholampoor <armingh379@gmail.com>, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 17 Nov 2020 18:02:11 -0800
In-Reply-To: <20201118063744.214744-1-armingh379@gmail.com>
References: <20201118063744.214744-1-armingh379@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-11-18 at 01:37 -0500, Armin Gholampoor wrote:
> Fixed bracing style issue.
> 
> Signed-off-by: Armin Gholampoor <armingh379@gmail.com>
> ---
>  net/ipv4/tcp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index b2bc3d7fe..37bc91e4a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3170,8 +3170,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
>  		else if (tp->repair_queue == TCP_RECV_QUEUE) {
>  			WRITE_ONCE(tp->rcv_nxt, val);
>  			WRITE_ONCE(tp->copied_seq, val);
> -		}
> -		else
> +		} else
>  			err = -EINVAL;
>  		break;


A more typical brace style would be to use braces on both arms.

And there is more than one of these in the file.

Please fix them all at the same time rather than just a single instance.

Something like:

---
 net/ipv4/tcp.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b285b338a019..ae4ec5e29802 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3155,9 +3155,9 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case TCP_REPAIR:
-		if (!tcp_can_repair_sock(sk))
+		if (!tcp_can_repair_sock(sk)) {
 			err = -EPERM;
-		else if (val == TCP_REPAIR_ON) {
+		} else if (val == TCP_REPAIR_ON) {
 			tp->repair = 1;
 			sk->sk_reuse = SK_FORCE_REUSE;
 			tp->repair_queue = TCP_NO_QUEUE;
@@ -3168,8 +3168,9 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		} else if (val == TCP_REPAIR_OFF_NO_WP) {
 			tp->repair = 0;
 			sk->sk_reuse = SK_NO_REUSE;
-		} else
+		} else {
 			err = -EINVAL;
+		}
 
 		break;
 
@@ -3183,16 +3184,16 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case TCP_QUEUE_SEQ:
-		if (sk->sk_state != TCP_CLOSE)
+		if (sk->sk_state != TCP_CLOSE) {
 			err = -EPERM;
-		else if (tp->repair_queue == TCP_SEND_QUEUE)
+		} else if (tp->repair_queue == TCP_SEND_QUEUE) {
 			WRITE_ONCE(tp->write_seq, val);
-		else if (tp->repair_queue == TCP_RECV_QUEUE) {
+		} else if (tp->repair_queue == TCP_RECV_QUEUE) {
 			WRITE_ONCE(tp->rcv_nxt, val);
 			WRITE_ONCE(tp->copied_seq, val);
-		}
-		else
+		} else {
 			err = -EINVAL;
+		}
 		break;
 
 	case TCP_REPAIR_OPTIONS:
@@ -3261,9 +3262,10 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 				break;
 			}
 			tp->window_clamp = 0;
-		} else
+		} else {
 			tp->window_clamp = val < SOCK_MIN_RCVBUF / 2 ?
 						SOCK_MIN_RCVBUF / 2 : val;
+		}
 		break;
 
 	case TCP_QUICKACK:
@@ -3287,8 +3289,8 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case TCP_FASTOPEN:
-		if (val >= 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
-		    TCPF_LISTEN))) {
+		if (val >= 0 &&
+		    ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {
 			tcp_fastopen_init_key_once(net);
 
 			fastopen_queue_tune(sk, val);


